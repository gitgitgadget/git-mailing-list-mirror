From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] send-pack: avoid redundant "pack-objects died with strange
 error"
Date: Tue, 12 Oct 2010 15:19:46 -0500
Message-ID: <20101012201946.GA15080@burratino>
References: <20101009201751.GK9348@bzzt.net>
 <20101010024124.GA20305@burratino>
 <20101010103327.GO9348@bzzt.net>
 <20101010180909.GA12320@burratino>
 <20101010185622.GX9348@bzzt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Arnout Engelen <arnouten@bzzt.net>
X-From: git-owner@vger.kernel.org Tue Oct 12 22:23:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5lNT-0001iC-8y
	for gcvg-git-2@lo.gmane.org; Tue, 12 Oct 2010 22:23:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757657Ab0JLUXJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Oct 2010 16:23:09 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:48705 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754684Ab0JLUXH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Oct 2010 16:23:07 -0400
Received: by ywi6 with SMTP id 6so1206833ywi.19
        for <git@vger.kernel.org>; Tue, 12 Oct 2010 13:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=OffA6SSsdoDBtrnpJJHe5k7zegZEQD+3Y2vw8jthHCg=;
        b=fpturIGvR9v/iTm9maNjjGlsYM/wc9fAxqKR+xlh9uw3QCOG94KY6EqDKSYnPebwys
         JSjmUfh96wGLzc+Jdz5BkRy88F0bXJNWnFA+YALzSfdjhTz+hjFhuToFrhGvuEeBAXdq
         sC4FMY9ObazyyN1I9JVnOM89PkRQRFOxMN8cw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=WmAk6cSU+7hP6j3P72WWjP6XYGxN5jiJqz9WRQiyFPvxLbHMHuoUMX9EpEHfXspUjv
         k9EKbl6OuLfkFH3wH8dWGffMb6ua0XsGqOTZNpuPGvSRmJTtK6NtSRTJkSjF/DwqtPK4
         81rzPRNz/JcNhunPg/btmnuMhf/R8FwkGgYuk=
Received: by 10.236.110.170 with SMTP id u30mr15939207yhg.11.1286914986879;
        Tue, 12 Oct 2010 13:23:06 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id 65sm2216416yhl.15.2010.10.12.13.23.05
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 12 Oct 2010 13:23:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101010185622.GX9348@bzzt.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158875>

Arnout Engelen wrote:

> arnouten@bird:~/asdf/notion$ git push sourceforge master
> raboofje@notion.git.sourceforge.net's password: 
> Counting objects: 21542, done.
> Compressing objects: 100% (4179/4179), done.
> fatal: Unable to create temporary file: Permission denied
> error: pack-objects died of signal 13
> error: pack-objects died with strange error
> error: failed to push some refs to 'ssh://raboofje@notion.git.sourceforge.net/gitroot/notion/notion' arnouten@bird:~/asdf/notion$

That reminds me: the output seems more noisy than it needs to be, no?

-- 8< --
Subject: send-pack: avoid redundant "pack-objects died with strange error"

Saying "pack-objects died with strange error" after "pack-objects
died of signal 13" seems kind of redundant.  The latter was
introduced when send-pack switched to the run-command API, which
reports abnormal exits on behalf of the caller.

Normal exits with nonzero status are not reported by run-command,
though.  Be more helpful in reporting them by including the exit
status while at it.

The result should look something like this:

	$ git push sf master
	Counting objects: 21542, done.
	Compressing objects: 100% (4179/4179), done.
	fatal: Unable to create temporary file: Permission denied
	error: pack-objects died of signal 13
	error: failed to push some refs to 'ssh://sf.net/gitroot/project/project'
	$

Or in the "controlled exit" case:

	[...]
	error: pack-objects died with status 128
	error: failed to push some refs to 'ssh://example.com/foo/bar'
	$

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/send-pack.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 481602d..51b722b 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -50,7 +50,7 @@ static int pack_objects(int fd, struct ref *refs, struct extra_have_objects *ext
 		NULL,
 	};
 	struct child_process po;
-	int i;
+	int i, status;
 
 	i = 4;
 	if (args->use_thin_pack)
@@ -100,9 +100,10 @@ static int pack_objects(int fd, struct ref *refs, struct extra_have_objects *ext
 		po.out = -1;
 	}
 
-	if (finish_command(&po))
-		return error("pack-objects died with strange error");
-	return 0;
+	status = finish_command(&po);
+	if (status > 0)
+		error("pack-objects died with status %d", status);
+	return status;
 }
 
 static int receive_status(int in, struct ref *refs)
-- 
1.7.2.3
