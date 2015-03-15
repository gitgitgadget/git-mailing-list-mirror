From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Bug in fetch-pack.c, please confirm
Date: Sat, 14 Mar 2015 23:37:37 -0700
Message-ID: <0758b2029b41448a77a4e4df1c4e406@74d39fa044aa309eaea14b9f57fe79c>
Cc: Git mailing list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 15 07:37:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YX2BN-0005lT-TU
	for gcvg-git-2@plane.gmane.org; Sun, 15 Mar 2015 07:37:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751368AbbCOGhs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Mar 2015 02:37:48 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:32851 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751166AbbCOGhr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Mar 2015 02:37:47 -0400
Received: by pdnc3 with SMTP id c3so26172818pdn.0
        for <git@vger.kernel.org>; Sat, 14 Mar 2015 23:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=MzyNQEEeuRRSy8IcAlnIuBzduVvWx1dloX1OG8v/7I4=;
        b=d2rMmK1NQisHwiSFRnn99zg/dJaxhBH5GEDhJsXDTN5EPm0YNXNG1ov8wxoOF1Ju6E
         JPGm8Viqvf1NyaX4/KDK2phhF2AdHwbVzWSO7OkwniTVB1aa5Kp172DoS7KuXo0p3BeY
         KBlg4axvJZXU+GRoAPsy1C4LVxWziq4vud2xIWrx6FqSNFTetzqeIgmMaiTRTsdjl4Qk
         KC0lqVR0q/OuUbeLA/azN1nhNaNZFlq4VPsyl7ndVH47WlrlfBeJlsjjP2Tr0eOVpBI3
         HFO4lrWx4dc6mXy5YbLUO3VFNgtYmdTdMsjGDI4vo70z75f50RTTIQKpWEJduJslq/v4
         OItA==
X-Received: by 10.66.169.202 with SMTP id ag10mr121549788pac.19.1426401467068;
        Sat, 14 Mar 2015 23:37:47 -0700 (PDT)
Received: from localhost.localdomain ([2002:48c0:ad8d:0:223:12ff:fe05:eebd])
        by mx.google.com with ESMTPSA id ht2sm11058637pdb.23.2015.03.14.23.37.45
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 14 Mar 2015 23:37:46 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265480>

Hi guys,

So I was looking at fetch-pack.c (from master @ 52cae643, but I think  
it's the same everywhere):

# Lines 626-648

     for (retval = 1, ref = *refs; ref ; ref = ref->next) {
             const unsigned char *remote = ref->old_sha1;
             unsigned char local[20];
             struct object *o;

             o = lookup_object(remote);
             if (!o || !(o->flags & COMPLETE)) {
                     retval = 0;
                     if (!args->verbose)
                             continue;
                     fprintf(stderr,
                             "want %s (%s)\n", sha1_to_hex(remote),
                             ref->name);
                     continue;
             }

             hashcpy(ref->new_sha1, local);
             if (!args->verbose)
                     continue;
             fprintf(stderr,
                     "already have %s (%s)\n", sha1_to_hex(remote),
                     ref->name);
     }

Peff, weren't you having some issue with want and have and hide refs?

Tell me please how the "local" variable above gets initialized?

It's declared on the stack inside the for loop scope so only  
guaranteed to have garbage.

It's passed to hashcpy which has this prototype:

  inline void hashcpy(unsigned char *sha_dst, const unsigned char *sha_src);

So it looks to me like garbage is copied into rev->new_sha1, yes?

Something's very wrong here.

It looks to me like the bug was introduced in 49bb805e (Do not ask for  
objects known to be complete. 2005-10-19).

I've taken a stab a a fix below.

-Kyle

-- 8< --
Subject: [PATCH] fetch-pack.c: do not use uninitialized sha1 value

Since 49bb805e (Do not ask for objects known to be complete. 2005-10-19)
when the read_ref call was replaced with a parse_object call, the
automatic variable 'local' containing an sha1 has been left uninitialized.

Subsequently in 1baaae5e (Make maximal use of the remote refs, 2005-10-28)
the parse_object call was replaced with a lookup_object call but still
the 'local' variable was left uninitialized.

However, it's used as the source to update another sha1 value in the case
that we already have it and in that case the other ref will end up with
whatever garbage was in the 'local' variable.

Fix this by removing the 'local' variable and using the value from the
result of the lookup_object call instead.

Signed-off-by: Kyle J. McKay <mackyle@gmail.com>
---
 fetch-pack.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 655ee642..c0b4d84f 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -621,29 +621,28 @@ static int everything_local(struct fetch_pack_args *args,
 		}
 	}
 
 	filter_refs(args, refs, sought, nr_sought);
 
 	for (retval = 1, ref = *refs; ref ; ref = ref->next) {
 		const unsigned char *remote = ref->old_sha1;
-		unsigned char local[20];
 		struct object *o;
 
 		o = lookup_object(remote);
 		if (!o || !(o->flags & COMPLETE)) {
 			retval = 0;
 			if (!args->verbose)
 				continue;
 			fprintf(stderr,
 				"want %s (%s)\n", sha1_to_hex(remote),
 				ref->name);
 			continue;
 		}
 
-		hashcpy(ref->new_sha1, local);
+		hashcpy(ref->new_sha1, o->sha1);
 		if (!args->verbose)
 			continue;
 		fprintf(stderr,
 			"already have %s (%s)\n", sha1_to_hex(remote),
 			ref->name);
 	}
 	return retval;
---
