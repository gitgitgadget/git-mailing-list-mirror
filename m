From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 6/8] run-command: add an asynchronous parallel child
 processor
Date: Mon, 14 Dec 2015 21:39:06 +0100
Message-ID: <566F28EA.3080802@kdbg.org>
References: <1450121838-7069-1-git-send-email-sbeller@google.com>
 <1450121838-7069-7-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: peff@peff.net, gitster@pobox.com, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	ericsunshine@gmail.com
To: Stefan Beller <sbeller@google.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 14 21:39:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8Zts-00021Z-5r
	for gcvg-git-2@plane.gmane.org; Mon, 14 Dec 2015 21:39:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753321AbbLNUjL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2015 15:39:11 -0500
Received: from bsmtp8.bon.at ([213.33.87.20]:61479 "EHLO bsmtp8.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752975AbbLNUjK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2015 15:39:10 -0500
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp8.bon.at (Postfix) with ESMTPSA id 3pKF1l4VHvz5tlR;
	Mon, 14 Dec 2015 21:39:07 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 96F7853A9;
	Mon, 14 Dec 2015 21:39:06 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.4.0
In-Reply-To: <1450121838-7069-7-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282403>

Am 14.12.2015 um 20:37 schrieb Stefan Beller:
> This allows to run external commands in parallel with ordered output
> on stderr.
>
> If we run external commands in parallel we cannot pipe the output directly
> to the our stdout/err as it would mix up. So each process's output will
> flow through a pipe, which we buffer. One subprocess can be directly
> piped to out stdout/err for a low latency feedback to the user.
>
> Example:
> Let's assume we have 5 submodules A,B,C,D,E and each fetch takes a
> different amount of time as the different submodules vary in size, then
> the output of fetches in sequential order might look like this:
>
>   time -->
>   output: |---A---| |-B-| |-------C-------| |-D-| |-E-|
>
> When we schedule these submodules into maximal two parallel processes,
> a schedule and sample output over time may look like this:
>
> process 1: |---A---| |-D-| |-E-|
>
> process 2: |-B-| |-------C-------|
>
> output:    |---A---|B|---C-------|DE
>
> So A will be perceived as it would run normally in the single child
> version. As B has finished by the time A is done, we can dump its whole
> progress buffer on stderr, such that it looks like it finished in no
> time. Once that is done, C is determined to be the visible child and
> its progress will be reported in real time.
>
> So this way of output is really good for human consumption, as it only
> changes the timing, not the actual output.
>
> For machine consumption the output needs to be prepared in the tasks,
> by either having a prefix per line or per block to indicate whose tasks
> output is displayed, because the output order may not follow the
> original sequential ordering:
>
>   |----A----| |--B--| |-C-|
>
> will be scheduled to be all parallel:
>
> process 1: |----A----|
> process 2: |--B--|
> process 3: |-C-|
> output:    |----A----|CB
>
> This happens because C finished before B did, so it will be queued for
> output before B.
>
> The detection when a child has finished executing is done the same way as
> two fold. First we check regularly if the stderr pipe still exists in an
> interleaved manner with other actions such as checking other children
> for their liveliness or starting new children. Once a child closed their
> stderr stream, we assume it is stopping very soon, such that we can use
> the `finish_command` code borrowed from the single external process
> execution interface.

I can't quite parse the first sentence in this paragraph. Perhaps 
something like this:

To detect when a child has finished executing, we check interleaved
with other actions (such as checking the liveliness of children or
starting new processes) whether the stderr pipe still exists. Once a
child closed its stderr stream, we assume it is terminating very soon,
and use finish_command() from the single external process execution
interface to collect the exit status.

>
> By maintaining the strong assumption of stderr being open until the
> very end of a child process, we can avoid other hassle such as an
> implementation using `waitpid(-1)`, which is not implemented in Windows.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
