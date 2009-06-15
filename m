From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] use xstrdup, not strdup in ll-merge.c
Date: Mon, 15 Jun 2009 14:46:04 +0200
Message-ID: <81b0412b0906150546p34ff53ceo81ea59785cf9d18a@mail.gmail.com>
References: <87bpoqoavp.fsf@meyering.net>
	 <81b0412b0906141503v14484d9fyea56198910305bfc@mail.gmail.com>
	 <87fxe2lybr.fsf@meyering.net>
	 <81b0412b0906150145j7c717a6ar33bb4f2ebd6095e1@mail.gmail.com>
	 <87vdmxluj8.fsf@meyering.net>
	 <81b0412b0906150439r755a7498ldddbca911b2fd36e@mail.gmail.com>
	 <877hzdlnt6.fsf@meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git list <git@vger.kernel.org>
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Mon Jun 15 14:46:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGBZp-0008Bu-5U
	for gcvg-git-2@gmane.org; Mon, 15 Jun 2009 14:46:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753172AbZFOMqG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Jun 2009 08:46:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752927AbZFOMqE
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jun 2009 08:46:04 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:51253 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752538AbZFOMqD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Jun 2009 08:46:03 -0400
Received: by bwz9 with SMTP id 9so3290450bwz.37
        for <git@vger.kernel.org>; Mon, 15 Jun 2009 05:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=KTkvZzpqEUrsaWqY0PJ8bF7h9uQFuqH2H9rcd82B1Cg=;
        b=m8ruc7Lv77V9gEX6j0txHYJfmefVy8djKvNaXektkxW7eWjLuZ+cWL5GxhD2CL2LzI
         wqYGCbyIZkeKoN6DKF0mtdLQ6+D9gRpZ5cVE9VfVYi+K15ofZ59m05U37B5ZDVfIZ6qk
         jMjjlrSoHCL/pewk6zBCFiaBsiZXsZa4CoDIQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=fu3nRSeY0mpp/Bo/AkGcmB7y7a1f8E7FLzQdltXHOLreuGVQUt5DFPcTbUrQ6pVY3Y
         Ls5K0jlC2rFfh9yevNkk3eM64rgEPBfFASLqExvpTWg5Mg5LfhTSihbn0fVPe7qWmIgL
         mEUdLe0DlNiCKF+JgW5+E/WkVQ71YN2nAvQfw=
Received: by 10.204.77.93 with SMTP id f29mr7006220bkk.74.1245069964299; Mon, 
	15 Jun 2009 05:46:04 -0700 (PDT)
In-Reply-To: <877hzdlnt6.fsf@meyering.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121602>

2009/6/15 Jim Meyering <jim@meyering.net>:
> Alex Riesen wrote:
>> 2009/6/15 Jim Meyering <jim@meyering.net>:
>>>
>>> Exactly. =C2=A0This is why I think it's not worthwhile to invest in
>>> a more precise diagnostic, here.
>>
>> I disagree. It is already hard to find starting point for debugging =
if
>> the failed code is just a layer: the config of ll-merge is called no=
t only
>> from the merge drivers, but also indirectly from the programs which
>> call the merge itself. Now, go figure where has it failed...
>
> If you're convinced of the value of such a change, go for it.

As much as I'd like to know as much as possible about why something
failed, I can't make a failure handling automatically simple (given the=
 tools).
I do suggest using goto to handle this particular OOM (below), but it l=
ooks
almost too ugly. Maybe I am just paranoid, and am overdoing this partic=
ular
case.

> Though it sounds like you're saying you'd prefer a stack trace.

I haven't though of that, but yes, that would be perfect (except for
a small problem where it is impossible to do in a portable way,
and there is know way to get information about).

The "goto oom" patch:

diff --git a/ll-merge.c b/ll-merge.c
index 31d6f0a..4977f20 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -230,8 +230,11 @@ static int read_merge_config(const char *var,
const char *value, void *cb)
 	int namelen;

 	if (!strcmp(var, "merge.default")) {
-		if (value)
+		if (value) {
 			default_ll_merge =3D strdup(value);
+			if (!default_ll_merge)
+				goto oom;
+		}
 		return 0;
 	}

@@ -266,6 +269,8 @@ static int read_merge_config(const char *var,
const char *value, void *cb)
 		if (!value)
 			return error("%s: lacks value", var);
 		fn->description =3D strdup(value);
+		if (!fn->description)
+			goto oom;
 		return 0;
 	}

@@ -289,6 +294,8 @@ static int read_merge_config(const char *var,
const char *value, void *cb)
 		 * status.
 		 */
 		fn->cmdline =3D strdup(value);
+		if (!fn->cmdline)
+			goto oom;
 		return 0;
 	}

@@ -296,10 +303,15 @@ static int read_merge_config(const char *var,
const char *value, void *cb)
 		if (!value)
 			return error("%s: lacks value", var);
 		fn->recursive =3D strdup(value);
+		if (!fn->recursive)
+			goto oom;
 		return 0;
 	}

 	return 0;
+oom:
+	return error("line merge: %s%s%s: out of memory", var,
+		     value ? " =3D ": "", value ? value: "");
 }

 static void initialize_ll_merge(void)
@@ -307,7 +319,8 @@ static void initialize_ll_merge(void)
 	if (ll_user_merge_tail)
 		return;
 	ll_user_merge_tail =3D &ll_user_merge;
-	git_config(read_merge_config, NULL);
+	if (git_config(read_merge_config, NULL) < 0)
+		exit(1);
 }

 static const struct ll_merge_driver *find_ll_merge_driver(const char
*merge_attr)
