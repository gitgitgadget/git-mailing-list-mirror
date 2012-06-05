From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [RFC 4/4] Add cat-blob report pipe from fast-import to remote-helper.
Date: Tue, 05 Jun 2012 10:51:32 +0200
Message-ID: <4FCDC894.7000905@viscovery.net>
References: <1338830455-3091-1-git-send-email-florian.achleitner.2.6.31@gmail.com> <1338830455-3091-2-git-send-email-florian.achleitner.2.6.31@gmail.com> <1338830455-3091-3-git-send-email-florian.achleitner.2.6.31@gmail.com> <1338830455-3091-4-git-send-email-florian.achleitner.2.6.31@gmail.com> <1338830455-3091-5-git-send-email-florian.achleitner.2.6.31@gmail.com> <20120605065628.GA25809@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 05 10:51:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbpUN-0001Pf-IN
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jun 2012 10:51:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758080Ab2FEIvh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jun 2012 04:51:37 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:3066 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757875Ab2FEIvg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2012 04:51:36 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.76)
	(envelope-from <j.sixt@viscovery.net>)
	id 1SbpUC-0000nG-W8; Tue, 05 Jun 2012 10:51:33 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 995361660F;
	Tue,  5 Jun 2012 10:51:32 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <20120605065628.GA25809@sigill.intra.peff.net>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199216>

Am 6/5/2012 8:56, schrieb Jeff King:
> On Mon, Jun 04, 2012 at 07:20:55PM +0200, Florian Achleitner wrote:
>> +static int fd_to_close;
>> +void close_fd_prexec_cb(void)
>> +{
>> +	if(debug)
>> +		fprintf(stderr, "close_fd_prexec_cb closing %d\n", fd_to_close);
>> +	close(fd_to_close);
>> +}
> 
> Note that preexec_cb does not work at all on Windows, as it assumes a
> forking model (rather than a spawn, which leaves no room to execute
> arbitrary code in the child). If all you want to do is open an extra
> pipe, then probably run-command should be extended to handle this
> (though I have no idea how complex that would be for the Windows side of
> things, it is at least _possible_, as opposed to preexec_cb, which will
> never be possible).

The lack of support for preexec_cb on Windows is actually not the problem
in this case. Our emulation of pipe() actually creates file handles that
are not inherited by child processes. (For the standard channels 0,1,2 we
rely on that dup() creates duplicates that *can* be inherited; so they
still work.)

The first problem with the new infrastructure in this patch is that dup()
is not called anywhere after pipe(). To solve this, we would have to
extend run-command in some way to allow passing along arbitrary pipes and
handles.

The second problem is more severe and is at the lowest level of our
infrastructure: We set up our child processes so that they know only about
file descriptors other than 0,1,2 to the child process. Even if the first
problem were solved, the child process does not receive sufficient
information to know that there are open file descriptors other than 0,1,2.
There is a facility to pass along this information from the parent to the
child, but we simply do not implement it.

IOW: Everything that uses --cat-blob-fd or a similar facility cannot work
on Windows without considerable additional effort.

-- Hannes
