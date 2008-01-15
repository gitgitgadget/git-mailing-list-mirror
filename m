From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH] treat any file with NUL as binary
Date: Tue, 15 Jan 2008 22:03:33 +0100
Message-ID: <A220A113-8D82-4D54-8759-BD7199FC22A8@zib.de>
References: <1200407309-10992-1-git-send-email-dpotapov@gmail.com>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 8BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 15 22:03:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEswi-00054a-Py
	for gcvg-git-2@gmane.org; Tue, 15 Jan 2008 22:03:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752263AbYAOVDE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 16:03:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751839AbYAOVDB
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 16:03:01 -0500
Received: from mailer.zib.de ([130.73.108.11]:46718 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751315AbYAOVDA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Jan 2008 16:03:00 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m0FL2ULc016871;
	Tue, 15 Jan 2008 22:02:30 +0100 (CET)
Received: from [192.168.178.21] (brln-4db83608.pool.einsundeins.de [77.184.54.8])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m0FL2Tfo026871
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Tue, 15 Jan 2008 22:02:29 +0100 (MET)
In-Reply-To: <1200407309-10992-1-git-send-email-dpotapov@gmail.com>
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70561>


On Jan 15, 2008, at 3:28 PM, Dmitry Potapov wrote:

> There are two heuristics in Git to detect whether a file is binary
> or text. One in xdiff-interface.c relied on existing NUL byte at
> the beginning. However, convert.c used a different heuristic, which
> relied that the number of non-printable symbols is less than 1%.
>
> Due to difference in approaches whether a file is binary or not,
> it was possible that a file that diff treats as binary will not be
> treated as text by CRLF conversation. This is very confusing for
> a user who seeing that 'git diff' shows file as binary expects it
> to be added as binary.
>
> This patch makes is_binary to consider any file that contains at
> least one NUL character as binary.

Shouldn't the commit message explicitly mention that the solution
is to make the check in convert.c stricter than the check in
xdiff-interface.c?  I think a comment in xdiff-interface.c
would also be a good thing to remember future developers about
this.


> ---
>
> Junio,
>
> I believe that the current behavior where 'git diff' shows me a file
> as binary and then adds it as text with crlf conversation is a bug.
>
> Though, it is not very likely to happen, it still possible cases where
> a binary file contains large amount of text. For instance, a tar file
> of text files can be such a file. Probably, word processor that store
> text in binary format may also generate a file with more 99% printable
> characters. So, such files will be considered as text by current  
> convert
> heuristic. Still such files are considered by diff due present of a  
> NUL
> character. This is very confusing for a user to see 'git diff' saying
> that a file is binary and then having it converted as text. Because I
> don't think that any real text file (especially one that requires CRLF
> conversation) may contain NUL character, I believe this change should
> improve binary heuristic and avoid user confusion.

I think this is a good idea.  When reading the code for the first
time it took me some time to accept that we really have different
ways for detecting a binary file and to understand how these
detections are related.

I also agree with Dimitry that convert.c should be stricter than
xdiff-interface.c, because everything else could be confusing. ...


> So, please, consider it for inclusion as a bug fix.

... Hence, this should be considered a bug fix.

The patch looks good to me.

	Steffen
