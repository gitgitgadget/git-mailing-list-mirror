From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: Re: [PATCH] Clarify text filter merge conflict reduction docs
Date: Wed, 30 Jun 2010 23:32:49 +0200
Message-ID: <0CF2361E-D010-4042-B481-6918BE2A9341@gmail.com>
References: <20100628080234.GA7134@pvv.org> <0cd82ad22a6f240ebcde0c2f3a437a805dae5668.1277753114.git.eyvind.bernhardsen@gmail.com> <7vk4phbyl5.fsf@alter.siamese.dyndns.org> <BE5ECD39-0A80-410B-87C9-5C86F082773C@gmail.com> <7v4ogk76sb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Finn Arne Gangstad <finnag@pvv.org>,
	"git\@vger.kernel.org List" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 30 23:33:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OU4u4-0003p4-5x
	for gcvg-git-2@lo.gmane.org; Wed, 30 Jun 2010 23:33:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932296Ab0F3Vc4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jun 2010 17:32:56 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:40906 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932092Ab0F3Vcy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Jun 2010 17:32:54 -0400
Received: by wyf23 with SMTP id 23so629816wyf.19
        for <git@vger.kernel.org>; Wed, 30 Jun 2010 14:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:mime-version
         :content-type:from:in-reply-to:date:cc:content-transfer-encoding
         :message-id:references:to:x-mailer;
        bh=RQy7Mt0zlbdjY0foQtWQxUtTUn2h+YWnFv4GZGxdNOU=;
        b=AIYY4cyml6+o6dN3SEMJiXD4MhPUpdANzW7KNks+r8AnLnnKkCm8PSBbV7PM+0SCPA
         O6QNi2W1evpgd9p5eDv9CuFzebPMlyudffWdhB6aA9zrhSDzisZf7MqgRgxm0Z++iS5n
         I5SqJBLwYlfd1bj4PlmmzQuOAfyaeyWDR0XUg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        b=PVIWTQgPStUb+ti5MzDi77jGQNp5TABHcbM62Q62JK40ubTf7pYPiu0uOimoiVlx66
         81YbEtwUGTa7exUKaY0yvtDo6awwRaPxyKj0iSmOr265JDBznKoIlAeNXe8NNQxivEPY
         MpXRmtmlxvMLlRDGazPrzrwzni11HLYEs3JmE=
Received: by 10.216.46.19 with SMTP id q19mr186409web.66.1277933572365;
        Wed, 30 Jun 2010 14:32:52 -0700 (PDT)
Received: from vredefort.d.eyvind.bernhardsens.net (eyvind.bernhardsens.net [84.49.224.5])
        by mx.google.com with ESMTPS id l4sm5057306wej.32.2010.06.30.14.32.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 30 Jun 2010 14:32:52 -0700 (PDT)
In-Reply-To: <7v4ogk76sb.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149999>

Thanks for the detailed review and rewrite!  I unexpectedly had to spend the evening working on non-git related stuff, so I haven't even had time to send my promised re-roll.

On 30. juni 2010, at 19.46, Junio C Hamano wrote:

> Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com> writes:
> 
>> Shouldn't the normalization in merge-recursive be conditional too?
> 
> True, but your patch to merge-recursive is broken, I think.  It should at
> least look like the attached rewrite.

Your patch is better than mine, but in my defense I think you misdiagnosed the big problems.  The error path in normalized_eq returned 0 in case of problems, making the caller assume that the files differ and generate a merge conflict, and the return code from normalize_buffer was used correctly (see below).

[...]

> If you had a test that made sure that the merge works for paths that do
> not need double-conversion, you might have caught the last issue.  I
> suspect that your new tests _only_ checked what happens to paths that
> actually triggers these double conversion, without making sure that the
> new code would not affect the cases where it shouldn't be involved, no?

The real tests I ran were a couple of huge merges, admittedly across a "text=auto" change, but most paths were not touched by either branch, so I would definitely have hit that issue.

> It is a common trap to fall into not testing the negative case, when you
> are working on your own shiny new toy.  Let's be more careful when writing
> new tests.

Yes, absolutely.  The tests are pretty threadbare for such a potentially dangerous change, so I'll cop to a "shiny new toy" charge.  I'll also cop to writing hard-to-read code, but I still think it worked :)

Even though I like your version better than mine, I have a few comments, only some of which are defensive:

> +	if (!core_ll_merge_double_convert)
> +		return sha_eq(o_sha, a_sha);

I would rather do this:

	if (sha_eq(o_sha, a_sha))
		return 1;
	if (!core_ll_merge_double_convert)
		return 0;

If the sha1s are equal before normalization the files will be equal after normalization, so there's no sense in going through the rigmarole.

Bikeshed colour, I know, but core_ll_merge_double_convert is unwieldy and also a bit inaccurate since it's not just for ll_merge.  How about core_merge_prefilter, with a corresponding change to the config setting?  (I had this change as part of my unsent re-roll).

> +	ret = 0; /* assume changed for safety */
> +	assert(o_sha && a_sha);
> +	if (read_sha1_strbuf(o_sha, &o) || read_sha1_strbuf(a_sha, &a))
> +		goto error_return;
> +	renormalize_buffer(path, o.buf, o.len, &o);
> +	renormalize_buffer(path, a.buf, o.len, &a);
> +	ret = (o.len == a.len && !memcmp(o.buf, a.buf, o.len));

This was one of your points, but I deliberately skipped the memcmp here if _neither_ of the renormalize_buffers did any work (binary "|" instead of boolean "||" to ensure both sides are evaluated, but the comment was perhaps a little obscure).

If the files had been equal without any normalization the sha_eq() would have caught it, so we know the files are different without having to compare them.

> +error_return:
> +	strbuf_release(&o);
> +	strbuf_release(&a);
> +	return ret;

I'm not a goto objector, just curious: what's the advantage of "goto error_return" here vs. having the renormalizing code inside the if and inverting the test?

Thanks again for taking the time to improve my patch.
-- 
Eyvind
