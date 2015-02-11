From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] merge-file: correctly open files when in a subdir
Date: Wed, 11 Feb 2015 11:02:45 -0800
Message-ID: <xmqqtwystgoa.fsf@gitster.dls.corp.google.com>
References: <CAPHKiG7vzKbtH7=cXD-7Cta=a-iy-ViMustn98z+VEog5ep2sg@mail.gmail.com>
	<xmqqwq3pv60p.fsf@gitster.dls.corp.google.com>
	<CAPHKiG6M9_fOjpx8Pt8UTpUcrS+tmqL3YcT11WyJJu8m6nkJ4A@mail.gmail.com>
	<xmqqd25gux4r.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Stefan Beller <stefanbeller@googlemail.com>
To: Aleksander Boruch-Gruszecki <aleksander.boruchgruszecki@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 20:02:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLcYm-0003g0-3t
	for gcvg-git-2@plane.gmane.org; Wed, 11 Feb 2015 20:02:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753283AbbBKTCs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2015 14:02:48 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62306 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752672AbbBKTCr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2015 14:02:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1EE7D38B83;
	Wed, 11 Feb 2015 14:02:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EsRd+RUwbc5JWh4mz5UY31DIUxk=; b=sqttdn
	rni6FxCIdq0Lm0qXUbQvmKiSNerH13PePGFKxuE8cJC26bSz4EGsxfVwDcZEwENh
	IYcUKAzDEOK2cd4uhvhC3gjgra50588ILPNzC2XrnVXuSO52zZ9/6FVcCfnTbvKY
	YZQ/GPjGcVzdbd9X6Vfb/F/jLRn2TXLOtOBiI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=L3IfEH8E40yFhchMUsjAk2i8ke4T7Ue9
	OGdkA33ZaMBhNW/D7z8Yw6hBQFlA0YKTiYFrNqK5G6lsgdqb9BqeQnWCvJ1zaK1R
	oHq05pS3bkvZpLTtu+FLkbfiUJ2REBlIY5yhCLMlEYNEJBpBY8YWC/S99iJxmqjQ
	S1jR+RRauXA=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1301638B82;
	Wed, 11 Feb 2015 14:02:47 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 53EAD38B7D;
	Wed, 11 Feb 2015 14:02:46 -0500 (EST)
In-Reply-To: <xmqqd25gux4r.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 11 Feb 2015 10:21:56 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 90B1CE9A-B220-11E4-AFF5-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263689>

Junio C Hamano <gitster@pobox.com> writes:

> Thanks, that makes sense and it also makes sense that checking the
> resulting content in dir/a.txt would make sense.  Then we many not
> need to add a new dir/deep/* test---after all they are checking the
> same thing.

Here is what I have right now, queued somewhere in 'pu', after
fixing it up a bit.

-- >8 --
From: Aleksander Boruch-Gruszecki <aleksander.boruchgruszecki@gmail.com>
Date: Sun, 8 Feb 2015 17:53:53 +0100
Subject: [PATCH] merge-file: correctly open files when in a subdir

run_setup_gently() is called before merge-file. This may result in changing
current working directory, which wasn't taken into account when opening a file
for writing.

Fix by prepending the passed prefix. Previous var is left so that error
messages keep referring to the file from the user's working directory
perspective.

Signed-off-by: Aleksander Boruch-Gruszecki <aleksander.boruchgruszecki@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/merge-file.c  | 3 ++-
 t/t6023-merge-file.sh | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin/merge-file.c b/builtin/merge-file.c
index 844f84f..232b768 100644
--- a/builtin/merge-file.c
+++ b/builtin/merge-file.c
@@ -90,7 +90,8 @@ int cmd_merge_file(int argc, const char **argv, const char *prefix)
 
 	if (ret >= 0) {
 		const char *filename = argv[0];
-		FILE *f = to_stdout ? stdout : fopen(filename, "wb");
+		const char *fpath = prefix_filename(prefix, prefixlen, argv[0]);
+		FILE *f = to_stdout ? stdout : fopen(fpath, "wb");
 
 		if (!f)
 			ret = error("Could not open %s for writing", filename);
diff --git a/t/t6023-merge-file.sh b/t/t6023-merge-file.sh
index 432f086..d0df869 100755
--- a/t/t6023-merge-file.sh
+++ b/t/t6023-merge-file.sh
@@ -69,7 +69,8 @@ test_expect_success 'works in subdirectory' '
 	cp new1.txt dir/a.txt &&
 	cp orig.txt dir/o.txt &&
 	cp new2.txt dir/b.txt &&
-	( cd dir && git merge-file a.txt o.txt b.txt )
+	( cd dir && git merge-file a.txt o.txt b.txt ) &&
+	test_path_is_missing a.txt
 '
 
 cp new1.txt test.txt
-- 
2.3.0-185-g073f588
