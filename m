From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2] send-pack: avoid redundant "pack-objects died with
 strange error"
Date: Sat, 16 Oct 2010 01:04:23 -0500
Message-ID: <20101016060423.GA26538@burratino>
References: <20101009201751.GK9348@bzzt.net>
 <20101010024124.GA20305@burratino>
 <20101010103327.GO9348@bzzt.net>
 <20101010180909.GA12320@burratino>
 <20101010185622.GX9348@bzzt.net>
 <20101012201946.GA15080@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Arnout Engelen <arnouten@bzzt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 16 08:08:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6zw9-0005Rd-7H
	for gcvg-git-2@lo.gmane.org; Sat, 16 Oct 2010 08:08:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752626Ab0JPGH5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Oct 2010 02:07:57 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:37093 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752208Ab0JPGH4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Oct 2010 02:07:56 -0400
Received: by gwaa18 with SMTP id a18so28784gwa.19
        for <git@vger.kernel.org>; Fri, 15 Oct 2010 23:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=BuMD+ZDbbyS6H3imgsFDvJtInGIOqcgZEymi2HHee/k=;
        b=YPK27Fab/SSJ7+k7jKaKwgPBlF75ZyGq2Q8aK82ZPEWFJtKnNnTIes2TjiwxmGlEm5
         5vBRCwMBtj9qW9Oy3wT7Cucro63Om27fYuE6hyn2JDWDdYgpV/djvhbINmApPWFpgV+F
         bfKZHgvafjf4n9d9ytj9bgpASaH/d4mkua4rQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ZbribgANfSpCAv4Ju8kz7habp0blugJMXtY4FB0DIwECYf7Jcivk6QkZTGbNKEQxJv
         YUyRELEHZNdKsyQLWJctEMYmqhlzqOJQrR9zLmO9PHyYddOxunE23ESyaD3zQKF+Be+D
         Ki3uSG4LZdH+c1zyTPUFOLBDDbBK/u41zEoNM=
Received: by 10.150.195.2 with SMTP id s2mr3005919ybf.71.1287209275179;
        Fri, 15 Oct 2010 23:07:55 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id m45sm261937yha.11.2010.10.15.23.07.53
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 15 Oct 2010 23:07:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101012201946.GA15080@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159153>

Saying "pack-objects died with strange error" after "pack-objects
died of signal 13" seems kind of redundant.  The latter was
introduced when send-pack switched to the run-command API, which
reports abnormal exits on behalf of the caller.

Normal exits with nonzero status are not reported by run-command,
though.  Be more helpful in reporting them by including the exit
status while at it (and be sure to continue to return a value
less than zero from pack_objects() for that case).

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
Jonathan Nieder wrote:

> +++ b/builtin/send-pack.c
> @@ -100,9 +100,10 @@ static int pack_objects(int fd, struct ref *refs, struct extra_have_objects *ext
>  		po.out = -1;
>  	}
>  
> -	if (finish_command(&po))
> -		return error("pack-objects died with strange error");
> +	status = finish_command(&po);
> +	if (status > 0)
> +		error("pack-objects died with status %d", status);
> +	return status;

Caller:

	if (pack_objects(...) < 0)

So making pack_objects return >0 where it used to return <0 would be
a regression. :(  An updated patch with the following minimal fix
squashed in follows.

	status = finish_command(&po);
	if (status > 0)
 -		error("pack-objects died with status %d", status);
 +		return error("pack-objects died with status %d", status);
	return status;
  }

 builtin/send-pack.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 481602d..8854748 100644
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
+		return error("pack-objects died with status %d", status);
+	return status;
 }
 
 static int receive_status(int in, struct ref *refs)
-- 
1.7.2.3
