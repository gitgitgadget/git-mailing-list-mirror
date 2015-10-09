From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/1] merge: fix cache_entry use-after-free
Date: Fri, 09 Oct 2015 15:51:23 -0700
Message-ID: <xmqqfv1joduc.fsf@gitster.mtv.corp.google.com>
References: <1444330071-8909-1-git-send-email-dturner@twitter.com>
	<1444330071-8909-2-git-send-email-dturner@twitter.com>
	<xmqqmvvtqgei.fsf@gitster.mtv.corp.google.com>
	<1444428963.8836.36.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git mailing list <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Sat Oct 10 00:52:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZkgWA-0005wr-E6
	for gcvg-git-2@plane.gmane.org; Sat, 10 Oct 2015 00:52:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755856AbbJIWvp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2015 18:51:45 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:33127 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755820AbbJIWvZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2015 18:51:25 -0400
Received: by pacex6 with SMTP id ex6so98700460pac.0
        for <git@vger.kernel.org>; Fri, 09 Oct 2015 15:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=K63FBxFqNDVQQ97a8kjaq0WBFe4X07H4oc6otQCobS4=;
        b=SFDFVhNQLpsLYGy0wrOzM3HS/cX5XxoZcdzXe2mU/+oYDgbsUyvfywMQdZnwQTcfxC
         RKSL09w06P9RYtxw8MSsD6zbZ0vbSpUygnqR9p0tietPI7z5y07RBoVeK+mS24SXiZkQ
         tMQTJuf7Za6qo47Ra+QyB9adfVyn4fS6NKBQtb14adsP2X8Chx5SrMMcBL/vMw+v69kr
         u5Js9eGrh4BgMAapyxNzo8NOKsEmH4EWdekCaVs6Zbi6zTk3a1aZw83bssQu5Ty4qG+t
         h5Gi2pgLksx+fDtPAvao1qerD2UIVEE3Zc/9DtxnOY2j4LDH4/63ZYSn7QnuXY7YnSVx
         Gmgw==
X-Received: by 10.68.241.234 with SMTP id wl10mr18274455pbc.27.1444431084995;
        Fri, 09 Oct 2015 15:51:24 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:1c62:e65b:3845:3a2b])
        by smtp.gmail.com with ESMTPSA id k10sm4407156pbq.78.2015.10.09.15.51.24
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 09 Oct 2015 15:51:24 -0700 (PDT)
In-Reply-To: <1444428963.8836.36.camel@twopensource.com> (David Turner's
	message of "Fri, 09 Oct 2015 18:16:03 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279320>

David Turner <dturner@twopensource.com> writes:

>> > +		assert(removed == dir);
>> > +		drop_ce_ref(dir->ce);
>> 
>> This is curious.  In remove_name_hash() you do not have the
>> corresponding assert.  Why is it necessary here (or is it
>> unnecessary over there)?
>
> It is unnecessary in any case: it's an assert rather than a check for an
> expected (or even unexpected) case.  That just happens to be where Keith
> first managed to track down the use-after free, so that's where he
> happened to put the assert while trying to debug it.  I'm in general in
> favor of more asserts rather than fewer, so I would prefer to keep it
> in.  But I can remove it if you like.

OK, it was just the inconsistency between the two made them look
curious, as if one of them is more likely to get broken, or the
patch author was not so sure about the assumption, or something.

>> > +	add_ce_ref(ce);
>> >  	add_name_hash(istate, ce);
>> >  }
>> 
>> What happens to the existing entry that used to be istate->cache[nr],
>> which may or may not be 'ce' that is replacing it?
>> 
>> It turns out that all three calling sites are safe, but it is not
>> immediately obvious why.  Perhaps some comment in front of the
>> function is in order, to warn those who may have to add a new caller
>> or restructure the existing calling chain, that istate->cache[nr] is
>> expected not to hold a live reference when the function is called,
>> or something?
>
> Happy to add it if you want, but to me it was clear without because if
> there were a value in istate->cache[nr], that old value would be leaked.

OK, that's sort-of-cheating, but is a sound short-cut ;-).

>> > +		if (old != istate->split_index->base->cache[new->index - 1]) {
>> > +			struct cache_entry *ce = istate->split_index->base->cache[new->index - 1];
>> > +			drop_ce_ref(ce);
>> > +		}
>> >  		istate->split_index->base->cache[new->index - 1] = new;
>> 
>> Does 'new' already have the right refcount at this point?
>
> I spoke to Keith, and he thinks we do need an add_ce_ref there. I'll fix
> that on the reroll.  Duy, do you agree?
