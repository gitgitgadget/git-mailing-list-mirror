From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v3] send-pack: avoid redundant "pack-objects died with
 strange error"
Date: Sat, 16 Oct 2010 12:09:54 -0500
Message-ID: <20101016170954.GA29619@burratino>
References: <20101009201751.GK9348@bzzt.net>
 <20101012201946.GA15080@burratino>
 <20101016060423.GA26538@burratino>
 <201010161125.33372.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Arnout Engelen <arnouten@bzzt.net>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sat Oct 16 19:13:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7AKE-0000CM-P4
	for gcvg-git-2@lo.gmane.org; Sat, 16 Oct 2010 19:13:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752332Ab0JPRNg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Oct 2010 13:13:36 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:33833 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751768Ab0JPRNf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Oct 2010 13:13:35 -0400
Received: by gyg13 with SMTP id 13so369713gyg.19
        for <git@vger.kernel.org>; Sat, 16 Oct 2010 10:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=NXmcNpppV+lVpnvHsltKgVmdi8HJrnd5UYQ8+L6526g=;
        b=KZlo0U4dEkaPTRHwjkg6sj2zekb6s431GjW2A3S0EYanRrwGKrxAbmxqPAFDtdfaBt
         LLU/caKr5mijBmtoTTZQBbqIGnzFhWZQpf6dAIxQRLYYAo3OJHYZ9iA1brTHZx8ED2XA
         xEOxvx38I1jw67Jo5KU1tNMdUYxmLsm2Jcgng=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Z2643EN9fexnPPBXwnnaAl/gvoe8qslFfuXV99jt7gxlkad10xt9/HWKGu+5uo1ZN2
         7+R4brioqQxy31lw/pGzzoZkCEBprSTFnlmKhrufFa7awnnOGaHkgx+m8Pr5xhnr9YkJ
         I4V1853OSvBJwx6u4eX50iQcKrIkoLCEel6ZQ=
Received: by 10.101.3.34 with SMTP id f34mr1076688ani.149.1287249210216;
        Sat, 16 Oct 2010 10:13:30 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id 25sm18275122anq.28.2010.10.16.10.13.25
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 16 Oct 2010 10:13:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201010161125.33372.j6t@kdbg.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159167>

Saying "pack-objects died with strange error" after "pack-objects died
of signal 13" seems kind of redundant.  The latter message was
introduced when the run-command API changed to report abnormal exits
on behalf of the caller (v1.6.5-rc0~86^2~5, 2009-07-04).

Similarly, after a controlled pack-objects failure (detectable as a
normal exit with nonzero status), a "died with strange error" message
would be redundant next to the message from pack-objects itself.

So leave off the "strange error" messages.

The result should look something like this:

	$ git push sf master
	Counting objects: 21542, done.
	Compressing objects: 100% (4179/4179), done.
	fatal: Unable to create temporary file: Permission denied
	error: pack-objects died of signal 13
	error: failed to push some refs to 'ssh://sf.net/gitroot/project/project'
	$

Or in the "controlled exit" case (contrived example):

	[...]
	fatal: delta size changed
	error: failed to push some refs to 'ssh://example.com/foo/bar'
	$

Improved-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
On Sat, Oct 16, 2010 at 11:25:33AM +0200, Johannes Sixt wrote:
> On Samstag, 16. Oktober 2010, Jonathan Nieder wrote:

>> 	[...]
>> 	error: pack-objects died with status 128
>> 	error: failed to push some refs to 'ssh://example.com/foo/bar'
>
> I sense that this quote is not complete. Did you strip some error message by 
> writing just "[...]"?

That was invented example output.

Googling for "pack-objects died with strange error" gives me [1], with
v1.6.2:

	$ git push
	Counting objects: 68, done.
	Delta compression using 2 threads.
	Compressing objects: 100% (50/50), done.
	Connection to SERVER closed by remote host.
	error: pack-objects died with strange error
	error: failed to push some refs to 'SERVER:PROJECT.git'

and [2], with v1.6.4.4:

	Counting objects: 4364, done.
	Delta compression using up to 2 threads.
	Compressing objects: 100% (4240/4240), done.
	error: pack-objects died with strange error | 44 KiB/s   
	error: failed to push some refs to 'mysite:main_site_repo'

and some similar examples.  All involve git versions before
v1.6.5-rc0~86^2~5 (run_command: report system call errors instead of
returning error codes, 2009-07-04) and after a triage turn out to be
signals.

Let's go with your fix (thanks!).

[1] http://stackoverflow.com/questions/718962/git-push-error-pack-objects-died-with-strange-error
[2] http://stackoverflow.com/questions/1781013/git-error-failed-to-push-some-refs-pack-objects-died-with-strange-error

 builtin/send-pack.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 481602d..8aa3031 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -101,7 +101,7 @@ static int pack_objects(int fd, struct ref *refs, struct extra_have_objects *ext
 	}
 
 	if (finish_command(&po))
-		return error("pack-objects died with strange error");
+		return -1;
 	return 0;
 }
 
-- 
1.7.2.3
