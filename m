From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 3/3] fast-export: output reset command for commandline revs
Date: Wed, 24 Oct 2012 20:02:40 +0200
Message-ID: <CAMP44s2hX=y+tH4ANJp_Jj3OD4zaNccroVOd+51NhvFz=xZd7A@mail.gmail.com>
References: <1320535407-4933-1-git-send-email-srabbelier@gmail.com>
	<1320535407-4933-4-git-send-email-srabbelier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Eric Herman <eric@freesa.org>,
	Fernando Vezzosi <buccia@repnz.net>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 24 20:03:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TR5ID-0005mV-Je
	for gcvg-git-2@plane.gmane.org; Wed, 24 Oct 2012 20:03:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965248Ab2JXSCn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Oct 2012 14:02:43 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:52222 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965228Ab2JXSCl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Oct 2012 14:02:41 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so728207oag.19
        for <git@vger.kernel.org>; Wed, 24 Oct 2012 11:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=pFTfZOHVEHKvs4/J2mR5H0+tFMScwomv3x+CGyLCG1c=;
        b=gtucBb/5X0lUHZLcBHbW3ZGPfTk6L3rGZac9LIEg44lgG+jl+ZrbOSZNZiqsx0M2uQ
         Xi5oVdxLXPT0n0Hc4IdvlLCJtUwIrY43zy5Oo50LGyJHog03S1Pb2L0zzKLRSm9GYK9y
         rDfifMsPjt2NWPJHJzpT+35G4hBuFeziO3RnRO9IU6B4D1LpToyQ2tXMh0250tNFV8zI
         5q9ZfigYILzwqPmd1a6xa0uK1q9KVysCm6XoseHoMskpS3DqZxh6dMNg5ZIXdCHSKNgx
         0lVAK6oxAEFwmVCrsWDpwbASTtikcpHDwYDeG/s0nH2ppd50BdF5GuuX/uMtI1KIUZ1L
         KL8A==
Received: by 10.182.38.101 with SMTP id f5mr13695678obk.80.1351101760491; Wed,
 24 Oct 2012 11:02:40 -0700 (PDT)
Received: by 10.60.4.74 with HTTP; Wed, 24 Oct 2012 11:02:40 -0700 (PDT)
In-Reply-To: <1320535407-4933-4-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208313>

On Sun, Nov 6, 2011 at 12:23 AM, Sverre Rabbelier <srabbelier@gmail.com> wrote:
> When a revision is specified on the commandline we explicitly output
> a 'reset' command for it if it was not handled already. This allows
> for example the remote-helper protocol to use fast-export to create
> branches that point to a commit that has already been exported.

This simpler patch does the same, doesn't it?

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 12220ad..3b4c2d6 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -523,10 +523,13 @@ static void get_tags_and_duplicates(struct
object_array *pending,
                                typename(e->item->type));
                        continue;
                }
-               if (commit->util)
-                       /* more than one name for the same object */
+               /*
+                * This ref will not be updated through a commit, lets make
+                * sure it gets properly updated eventually.
+                */
+               if (commit->util || commit->object.flags & SHOWN)
                        string_list_append(extra_refs,
full_name)->util = commit;
-               else
+               if (!commit->util)
                        commit->util = full_name;
        }
 }

> Initial-patch-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
> ---
>
>   Most of the hard work for this patch was done by Dscho. The rest of
>   it was basically me applying the technique used by jch in c3502fa
>   (25-08-2011 do not include sibling history in --ancestry-path).
>
>   The if statement dealing with tag_of_filtered_mode is not as
>   elegant as either me or Dscho would have liked, but we couldn't
>   find a better way to determine if a ref is a tag at this point
>   in the code.

Which is needed why?

Right now if I do:
% git fast-export --{im,ex}port-marks=/tmp/marks foo1 tag-to-foo1

Where tag-to-foo1 is a tag that that points to foo1, I get a reset for that.

>   Additionally, the elem->whence != REV_CMD_RIGHT case should really
>   check if REV_CMD_RIGHT_REF, but as this is not provided by the
>   ref_info structure this is left as is. A result of this is that
>   incorrect input will result in incorrect output, rather than an
>   error message. That is: `git fast-export a..<sha1>` will
>   incorrectly generate a `reset <sha1>` statement in the fast-export
>   stream.

I don't see the point of this.

Besides, you can check the return value of dwim_ref, if it's not 1,
then you shouldn't generate a reset.

>   The dwim_ref bit is a double work (it has already been done by the
>   caller of this function), but I decided it would be more work to
>   pass this information along than to recompute it for the few
>   commandline refs that were relevant.

It's already stored in commit->util, you don't need to do that.

As I said, I think the patch above does the trick, and it even has the
advantage of not having the above a..<SHA-1> issues.

Cheers.

-- 
Felipe Contreras
