From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v5 15/15] fast-export: don't handle uninteresting refs
Date: Wed, 21 Nov 2012 04:03:03 +0100
Message-ID: <CAMP44s0UhTm7rRAQOHbwnv682xWCmD2JKQJBRB7+pXmzBUPqOw@mail.gmail.com>
References: <1352642392-28387-1-git-send-email-felipe.contreras@gmail.com>
	<1352642392-28387-16-git-send-email-felipe.contreras@gmail.com>
	<CAMP44s0WH-P7WY4UqhMX3WdrrSCYXUR9yCgsUV+mzLOCK5LkHQ@mail.gmail.com>
	<7vd2z7rj3y.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Max Horn <max@quendi.de>, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Pete Wyckoff <pw@padd.com>, Ben Walton <bdwalton@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 21 04:03:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tb0av-00085I-4M
	for gcvg-git-2@plane.gmane.org; Wed, 21 Nov 2012 04:03:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753069Ab2KUDDG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Nov 2012 22:03:06 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:64071 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751819Ab2KUDDE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Nov 2012 22:03:04 -0500
Received: by mail-ob0-f174.google.com with SMTP id wc20so6622561obb.19
        for <git@vger.kernel.org>; Tue, 20 Nov 2012 19:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=CoScXLly+uGEAf6QPCbwyA1RkRkSeGoojOc5HBFRktk=;
        b=mu8J1AhPPaRwjSIzyu9LLvPSGog3InkvbQIIg1ykMr9eLrMI1S00be0aaSwZMBxo2t
         16IxR/Nr4FcFK2M22zCQ+EmNBPuOAKKCL02KVrZ/9ZAc0dRRNiFnq0IDjWordBO7RCfK
         OjWOpM9OMiMc9S4+qATim6tHXY0qVCwS8u+7B+Wwlk40lTFA7xoo/dnJyrCUswL2Wbgm
         GnRnrflST6/xNfTxOHrJooeEnho3KTAbZgxyPjZNDF6s+2vDPnAE/SuOS79YJgMBMENc
         kZNMgffizRafpiPi04xxEu74MTydMpskwq8AEmBZDCkCiufstzuoulJYDP0sbgIgBTIF
         D+Mg==
Received: by 10.182.111.104 with SMTP id ih8mr15238011obb.13.1353466983310;
 Tue, 20 Nov 2012 19:03:03 -0800 (PST)
Received: by 10.60.28.232 with HTTP; Tue, 20 Nov 2012 19:03:03 -0800 (PST)
In-Reply-To: <7vd2z7rj3y.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210131>

On Tue, Nov 20, 2012 at 11:43 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> Of course, transport-helper shouldn't even be specifying the negative
>> (^) refs, but that's another story.
>
> Hrm, I am not sure I understand what you mean by this.
>
> How should it be telling the fast-export up to what commit the
> receiving end should already have the history for (hence they do not
> need to be sent)?  Or are you advocating to re-send the entire
> history down to the root commit every time?

No, it would not re-send the whole history, that's what marks are for.

And right now it doesn't exactly which was the last commit. Let's
suppose the remote helper has a refspec like this:

refs/heads/*:refs/hg/origin/heads/*

1) What happens the first time you push?

5203a268546295ebd895fd87522217ef53bd3313 refs/heads/master
5203a268546295ebd895fd87522217ef53bd3313 refs/remotes/tmp/master

Notice how the remote ref is updated correctly, but it's not the
remote helper refspec, so the next time you push, you will from root.

It's only when you fetch that you get the refspec'ed refs:

5203a268546295ebd895fd87522217ef53bd3313 refs/heads/master
5203a268546295ebd895fd87522217ef53bd3313 refs/hg/tmp/heads/master
5203a268546295ebd895fd87522217ef53bd3313 refs/remotes/tmp/master

So, there's already a mismatch.

2) What happens when you have no marks?

You get something like:
reset refs/heads/heads
from :0

Which is totally useless. Somebody proposed a patch that would replace
the :0 with a git sha-1, but that is equally useless for a remote
helper: we need a hg ref id, or a bzr id, or whatever, and no, there's
mapping between git sha-1's and hg ref ids, there's only git->mark
mark->hg, without marks, there's no way to map the git id to the hg
id.

3) What happens when you have a refspec like this?

*:*

Now nothing works, because we would be requesting ^refs/heads/master
refs/heads/master.

And according to the documentation, this is the default when no
refspec is used, which is not true.

4) What happens when there's no refspec at all.

Now it's even worst; nothing gets done at all:

if (!data->refspecs)
	continue;

I documented all this breakages in this patch:

http://article.gmane.org/gmane.comp.version-control.git/209365

not ok 10 - push new branch with old:new refspec # TODO known breakage
ok 11 - cloning without refspec
ok 12 - pulling without refspecs
not ok 13 - pushing without refspecs # TODO known breakage
not ok 14 - pulling with straight refspec # TODO known breakage
not ok 15 - pushing with straight refspec # TODO known breakage
not ok 16 - pulling without marks # TODO known breakage
not ok 17 - pushing without marks # TODO known breakage

And if you apply this patch:

--- a/transport-helper.c
+++ b/transport-helper.c
@@ -750,6 +750,7 @@ static int push_refs_with_export(struct transport
*transport,
        struct helper_data *data = transport->data;
        struct string_list revlist_args = STRING_LIST_INIT_NODUP;
        struct strbuf buf = STRBUF_INIT;
+       struct remote *remote = transport->remote;

        helper = get_helper(transport);

@@ -761,22 +762,23 @@ static int push_refs_with_export(struct
transport *transport,
                char *private;
                unsigned char sha1[20];

-               if (!data->refspecs)
+               if (ref->deletion)
+                       die("remote-helpers do not support ref deletion");
+
+               if (!ref->peer_ref)
+                       continue;
+
+               string_list_append(&revlist_args, ref->peer_ref->name);
+
+               if (!data->import_marks)
                        continue;
-               private = apply_refspecs(data->refspecs,
data->refspec_nr, ref->name);
+
+               private = apply_refspecs(remote->fetch,
remote->fetch_refspec_nr, ref->name);
                if (private && !get_sha1(private, sha1)) {
                        strbuf_addf(&buf, "^%s", private);
                        string_list_append(&revlist_args,
strbuf_detach(&buf, NULL));
                }
                free(private);
-
-               if (ref->deletion) {
-                       die("remote-helpers do not support ref deletion");
-               }
-
-               if (ref->peer_ref)
-                       string_list_append(&revlist_args, ref->peer_ref->name);
-
        }

        if (get_exporter(transport, &exporter, &revlist_args))

ok 13 - pushing without refspecs # TODO known breakage
ok 14 - pulling with straight refspec # TODO known breakage
ok 15 - pushing with straight refspec # TODO known breakage
ok 16 - pulling without marks # TODO known breakage
ok 17 - pushing without marks # TODO known breakage

Cheers.

-- 
Felipe Contreras
