From: Elia Pinto <gitter.spiros@gmail.com>
Subject: Re: Bug in "git rev-parse --verify"
Date: Sat, 30 Mar 2013 09:14:02 +0100
Message-ID: <CA+EOSBnXPgLhaCgDp5t94eFUXxiA-iufuJR8KCCvOTgczLCtWw@mail.gmail.com>
References: <51543FDB.9010109@alum.mit.edu>
	<CAPc5daUqzz=9TBmj2Q0MHqEc6gMHxXoGr9+JV3hq76zDKJAyCw@mail.gmail.com>
	<515462FB.9040605@alum.mit.edu>
	<20130328153808.GB3337@sigill.intra.peff.net>
	<7vli97v558.fsf@alter.siamese.dyndns.org>
	<51565F96.1020203@alum.mit.edu>
	<7vk3opr0ke.fsf@alter.siamese.dyndns.org>
	<51567844.7030503@alum.mit.edu>
	<7vboa1qtnb.fsf@alter.siamese.dyndns.org>
	<7vhajtpdtc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 30 09:14:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULqvs-00052h-Bd
	for gcvg-git-2@plane.gmane.org; Sat, 30 Mar 2013 09:14:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754486Ab3C3IOG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Mar 2013 04:14:06 -0400
Received: from mail-ve0-f174.google.com ([209.85.128.174]:33774 "EHLO
	mail-ve0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752871Ab3C3IOD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Mar 2013 04:14:03 -0400
Received: by mail-ve0-f174.google.com with SMTP id jz10so1130916veb.19
        for <git@vger.kernel.org>; Sat, 30 Mar 2013 01:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:content-type;
        bh=BCTA76fSXenR1ZR9sU2HtNyrPjD4T4UlswwjOVgqrAo=;
        b=v02lMfR9iOurgPzGf505FWamJkJvDpROmpSEYfYf4RsZbwuyjjNoUpL5/13SvTT5c2
         bXF+Ob4engisfW/PxMYozNzIEEZ5ksNWI4tejrSQ1/jKtkI32K3xloQnJsf0B7mDgDUJ
         2HZweCZA9WzkaIYg2cm4bz0VtdVHyLolcpAOkrC7lglo5BzUsPPtuMCngHjoO4NbD/Pb
         VaBr+3vxKV+gK7TSK0yEU8TtbdxamU+6lNH/ndCEPmu25Ydfs6DGfUg5RdAfxDgB7/qB
         LLsidI9r2z300WTT0F9doahBWzmTrIOR3cJcOYKeW4iJtxlK5PwpfBkf82unBEhbLk6D
         hAJw==
X-Received: by 10.58.11.133 with SMTP id q5mr3821190veb.47.1364631242336; Sat,
 30 Mar 2013 01:14:02 -0700 (PDT)
Received: by 10.52.118.97 with HTTP; Sat, 30 Mar 2013 01:14:02 -0700 (PDT)
In-Reply-To: <7vhajtpdtc.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219567>

Fwiw, look very a sound idea for me.

Best

2013/3/30, Junio C Hamano <gitster@pobox.com>:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> What we may want is another type peeling operator, ^{object}.
>> that makes sure it is an object, like this:
>>
>>     rev-parse --verify 572a535454612a046e7dd7404dcca94d6243c788^{object}
>>
>> It asks "I have this 40-hex; I want an object out of it", just like
>> frotz^{tree} is "I have 'frotz'; I want a tree-ish" for any value of
>> 'frotz'.
>>
>> With that, a use case that it wants to see _any_ object can safely
>> use 'rev-parse --verify "$userinput^{object}' without an annotated
>> tag getting in the way.
>>
>> How does that sound?
>
> Perhaps something like this.  Note that the last hunk is unrelated
> thinko-fix I noticed while browsing the code.
>
> -- >8 --
> Subject: sha1_name.c: ^{object} peeler
>
> A string that names an object can be suffixed with ^{type} peeler to
> say "I have this object name; peel it until you get this type. If
> you cannot do so, it is an error".  v1.8.2^{commit} asks for a commit
> that is pointed at an annotated tag v1.8.2; v1.8.2^{tree} unwraps it
> further to the top-level tree object.  A special suffix ^{} (i.e. no
> type specified) means "I do not care what it unwraps to; just peel
> annotated tag until you get something that is not a tag".
>
> When you have a random user-supplied string, you can turn it to a
> bare 40-hex object name, and cause it to error out if such an object
> does not exist, with:
>
> 	git rev-parse --verify "$userstring^{}"
>
> for most objects, but this does not yield the tag object name when
> $userstring refers to an annotated tag.
>
> Introduce a new suffix, ^{object}, that only makes sure the given
> name refers to an existing object.  Then
>
> 	git rev-parse --verify "$userstring^{object}"
>
> becomes a way to make sure $userstring refers to an existing object.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  sha1_name.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/sha1_name.c b/sha1_name.c
> index c50630a..85b6e75 100644
> --- a/sha1_name.c
> +++ b/sha1_name.c
> @@ -594,7 +594,7 @@ struct object *peel_to_type(const char *name, int
> namelen,
>  	while (1) {
>  		if (!o || (!o->parsed && !parse_object(o->sha1)))
>  			return NULL;
> -		if (o->type == expected_type)
> +		if (expected_type == OBJ_ANY || o->type == expected_type)
>  			return o;
>  		if (o->type == OBJ_TAG)
>  			o = ((struct tag*) o)->tagged;
> @@ -645,6 +645,8 @@ static int peel_onion(const char *name, int len,
> unsigned char *sha1)
>  		expected_type = OBJ_TREE;
>  	else if (!strncmp(blob_type, sp, 4) && sp[4] == '}')
>  		expected_type = OBJ_BLOB;
> +	else if (!prefixcmp(sp, "object}"))
> +		expected_type = OBJ_ANY;
>  	else if (sp[0] == '}')
>  		expected_type = OBJ_NONE;
>  	else if (sp[0] == '/')
> @@ -654,6 +656,8 @@ static int peel_onion(const char *name, int len,
> unsigned char *sha1)
>
>  	if (expected_type == OBJ_COMMIT)
>  		lookup_flags = GET_SHA1_COMMITTISH;
> +	else if (expected_type == OBJ_TREE)
> +		lookup_flags = GET_SHA1_TREEISH;
>
>  	if (get_sha1_1(name, sp - name - 2, outer, lookup_flags))
>  		return -1;
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

-- 
Inviato dal mio dispositivo mobile
