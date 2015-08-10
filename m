From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 10/17] path.c: drop git_path_submodule
Date: Mon, 10 Aug 2015 15:57:31 -0700
Message-ID: <xmqqbneeu4ys.fsf@gitster.dls.corp.google.com>
References: <20150810092731.GA9027@sigill.intra.peff.net>
	<20150810093627.GJ30981@sigill.intra.peff.net>
	<xmqqfv3qu5a7.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 11 00:57:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOw0g-0002p2-2N
	for gcvg-git-2@plane.gmane.org; Tue, 11 Aug 2015 00:57:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933274AbbHJW5d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2015 18:57:33 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:36078 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754724AbbHJW5d (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2015 18:57:33 -0400
Received: by pdco4 with SMTP id o4so76189939pdc.3
        for <git@vger.kernel.org>; Mon, 10 Aug 2015 15:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=xxCdHsI8MnV8RWurOXk92sCqLgVFQeBlB+oe71/sf1E=;
        b=dhgzM1bmexAt1mc7egftUwej9ifIom1fKbJapH3OH4lMKlSKSaF+y2TefHNiTnnzBr
         PP6VJwqwb5o6tYoog/vCdJ7Eqrxaq+hXjBoFCowdvY/TI/4qxcXX3MACYFSUaDaUUIiD
         KAJXi+Z1GBn1iCWk4PDP1Vg3bXegN2p8jv2Qziz09ayv84onhlrj8EooytRIWvOAjdtK
         5uh1eLwUpWdO4b3KeohEBfrMYDTb3LXnfA9X2TPJqgmuME8d5ytz/1cL2fLImJk8ujiz
         7jAmAniln8gPtkRRu9+f6GRXPJHhYgAsH7mGLXMo8hmKu/NNApXpixJzM8ayqbNdBYKr
         Kq8w==
X-Received: by 10.70.130.5 with SMTP id oa5mr50016852pdb.55.1439247452800;
        Mon, 10 Aug 2015 15:57:32 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:7d90:bc93:a451:6e95])
        by smtp.gmail.com with ESMTPSA id if9sm5627pbc.89.2015.08.10.15.57.32
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 10 Aug 2015 15:57:32 -0700 (PDT)
In-Reply-To: <xmqqfv3qu5a7.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 10 Aug 2015 15:50:40 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275663>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> There are no callers of the slightly-dangerous static-buffer
>> git_path_submodule left. Let's drop it.
>
> There are a few callers added on 'pu', though.

Actually there is only one.  Here is a proposed evil merge.

diff --git a/submodule.c b/submodule.c
index dfe8b7b..7ab08a1 100644
--- a/submodule.c
+++ b/submodule.c
@@ -120,34 +120,35 @@ void stage_updated_gitmodules(void)
 static int add_submodule_odb(const char *path)
 {
 	struct alternate_object_database *alt_odb;
-	const char *objects_directory;
+	struct strbuf objects_directory = STRBUF_INIT;
 	int ret = 0;
 
-	objects_directory = git_path_submodule(path, "objects/");
-	if (!is_directory(objects_directory)) {
+	strbuf_git_path_submodule(&objects_directory, "objects/", "%s", path);
+	if (!is_directory(objects_directory.buf)) {
 		ret = -1;
 		goto done;
 	}
 
 	/* avoid adding it twice */
 	for (alt_odb = alt_odb_list; alt_odb; alt_odb = alt_odb->next)
-		if (alt_odb->name - alt_odb->base == strlen(objects_directory) &&
-				!strcmp(alt_odb->base, objects_directory))
+		if (alt_odb->name - alt_odb->base == objects_directory.len &&
+				!strcmp(alt_odb->base, objects_directory.buf))
 			goto done;
 
-	alt_odb = xmalloc(strlen(objects_directory) + 42 + sizeof(*alt_odb));
+	alt_odb = xmalloc(objects_directory.len + 42 + sizeof(*alt_odb));
 	alt_odb->next = alt_odb_list;
-	strcpy(alt_odb->base, objects_directory);
-	alt_odb->name = alt_odb->base + strlen(objects_directory);
+	strcpy(alt_odb->base, objects_directory.buf);
+	alt_odb->name = alt_odb->base + objects_directory.len;
 	alt_odb->name[2] = '/';
 	alt_odb->name[40] = '\0';
 	alt_odb->name[41] = '\0';
 	alt_odb_list = alt_odb;
 
 	/* add possible alternates from the submodule */
-	read_info_alternates(objects_directory, 0);
+	read_info_alternates(objects_directory.buf, 0);
 	prepare_alt_odb();
 done:
+	strbuf_release(&objects_directory);
 	return ret;
 }
 
