From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [remote rejected] master -> master (n/a (unpacker error))
Date: Thu, 13 May 2010 08:56:19 -0500
Message-ID: <20100513135619.GA16848@progeny.tock>
References: <AANLkTinV2U6Lbbl0N7jVAESEi0mZQ_D3slMEYa68vRT4@mail.gmail.com>
 <20100513005218.GA20655@progeny.tock>
 <m2r5lgaqdb.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Robert Buck <buck.robert.j@gmail.com>,
	"git@vger.kernel.org List" <git@vger.kernel.org>,
	Chris Packham <judge.packham@gmail.com>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Thu May 13 15:55:58 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCYtJ-0005rf-Sn
	for gcvg-git-2@lo.gmane.org; Thu, 13 May 2010 15:55:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754518Ab0EMNzw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 May 2010 09:55:52 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:53315 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750873Ab0EMNzv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 May 2010 09:55:51 -0400
Received: by vws17 with SMTP id 17so502258vws.19
        for <git@vger.kernel.org>; Thu, 13 May 2010 06:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=abT5FRw5Doc0cY/DkO7beUrJDzVFjfvhkNi+6HxaFr8=;
        b=oNt/G+D3KSBdWHtpbS+PZJ/FHdsVtv2EHEcav3zp3VkdwYDPxKjQKyS72YS4QiGfdJ
         C9C2lNuY+lqsc7fwRyxzGCO9bntHOfAwdddJKhNTUaKgKjGzOr16A9XUzf8it8IXqT/T
         0pp221ZR89vacXmZri2HIAn98AqKdhKN/tDhA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=n8I0nSYMPzgkf82akmgdFJeqGDP2Z3Xn87n1ui74QzLllsPpVfQQt4rYzt1tIBZvR/
         xQOQvRAsQPFF/9D4kf/sopyPHAHF3M3Yd5YFHm8y3t5BGeNuO47eOzNtqDXp/mc/5kg0
         dPlJlui6JftMCMZrNGBH36/7u5WzhQsCbH26I=
Received: by 10.229.238.70 with SMTP id kr6mr5456071qcb.49.1273758950234;
        Thu, 13 May 2010 06:55:50 -0700 (PDT)
Received: from progeny.tock ([98.212.3.231])
        by mx.google.com with ESMTPS id a11sm363668qco.16.2010.05.13.06.55.48
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 13 May 2010 06:55:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <m2r5lgaqdb.fsf@igel.home>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147005>

Andreas Schwab wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> In your case, all 16384 trials yielded the same result: file already
>> existed.
>
> IMHO it is much more likely that a race happened between two git
> processes each wanting to create the .git/objects/e6 directory.

Good catch.  But wasn=E2=80=99t the problem reproducible?

In any event, that such a race is possible is not so nice.  Here=E2=80=99=
s
a na=C3=AFve fix; it does not address other races, such as hash-object
versus prune.  Maybe git ought to acquire some sort of lock before
writing to the object dir in a shared clone.

diff --git a/sha1_file.c b/sha1_file.c
index bbb819f..d305e53 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2244,6 +2244,13 @@ static inline int directory_size(const char *fil=
ename)
 	return s - filename + 1;
 }
=20
+static int ensure_directory_exists(const char *dir)
+{
+	if (mkdir(dir, 0777) && errno !=3D EEXIST)
+		return -1;
+	return adjust_shared_perm(dir);
+}
+
 /*
  * This creates a temporary file in the same directory as the final
  * 'filename'
@@ -2266,7 +2273,7 @@ static int create_tmpfile(char *buffer, size_t bu=
fsiz, const char *filename)
 		/* Make sure the directory exists */
 		memcpy(buffer, filename, dirlen);
 		buffer[dirlen-1] =3D 0;
-		if (mkdir(buffer, 0777) || adjust_shared_perm(buffer))
+		if (ensure_directory_exists(buffer))
 			return -1;
=20
 		/* Try again */
--=20
