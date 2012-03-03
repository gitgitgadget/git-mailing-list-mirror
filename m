From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Perform cheaper connectivity check when pack is used
 as medium
Date: Fri, 02 Mar 2012 22:59:19 -0800
Message-ID: <7vfwdq8914.fsf@alter.siamese.dyndns.org>
References: <7vmx849ma8.fsf@alter.siamese.dyndns.org>
 <1330435109-4437-1-git-send-email-pclouds@gmail.com>
 <7vwr73h6td.fsf@alter.siamese.dyndns.org>
 <CACsJy8D7JB9bzOvammGAx1rW04DEUCVzvfp-_Q1KtE9G00rZVQ@mail.gmail.com>
 <7v1upagb8z.fsf@alter.siamese.dyndns.org>
 <CACsJy8B7u-rvnFZKi4t2CoB=J3Ra8pWxK4439NTdnHQDhm2ibQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 03 07:59:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3iwC-0001bV-7v
	for gcvg-git-2@plane.gmane.org; Sat, 03 Mar 2012 07:59:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751312Ab2CCG7X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Mar 2012 01:59:23 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53138 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751203Ab2CCG7W (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2012 01:59:22 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D378B7FD3;
	Sat,  3 Mar 2012 01:59:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mZ8vsMsFeLuVvl9yXGOZpon6k+w=; b=lJMhpM
	/CzPDXLPT0XZpzInkQJrwj57ldsqQyLSuyVFuJUoWDyo034dgRlW7pW1DaLM0nnf
	xEy/WaFy28BohWMxvoSbjCSVS1aQzADZlZ3u9E1hY5m1ExEfroxc/Zqb4L/x1Pkj
	i+EeYoL0BzKGB8tRazogPRL/8q+ZpmA8TZqYE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XHMk39ZjzkO/2OKvLRXvfB3i6gMTUpwT
	6s85AfL3hXZ9c4vd9Xtw7/ROEqW/xROwnV854VBoWdHcYjvvj/TPJtOG66V/NvNv
	ciOOyXzOJ+svOV3csDQ9xzwOb1nV4YbB10sqk7pigMad1O1KAad81NA5Ik5DNNZ4
	ay8LSp3+fAI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CA3087FD2;
	Sat,  3 Mar 2012 01:59:21 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4FD637FD0; Sat,  3 Mar 2012
 01:59:21 -0500 (EST)
In-Reply-To: <CACsJy8B7u-rvnFZKi4t2CoB=J3Ra8pWxK4439NTdnHQDhm2ibQ@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Sat, 3 Mar 2012 10:05:27 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 672E30DA-64FE-11E1-94FA-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192095>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> It won't help the unpack-objects case. But unpack-objects is only used
> when the pack has less than a certain number of objects, doing heavy
> check in that case should not take too long. Yes, I was thinking I
> would pass pack identity down the verify-pack callchain for index-pack
> case.

Yes, I think we are on the same track; see below.

>> I also suspect that more than trivial amount of computation is needed to
>> determine if a given object exists only in a single pack, so the end
>> result may not be that much cheaper than the current --verify-object code.
>
> Objects can exist in multiple packs right now if they are base
> objects. I'm not sure why you need to check for object existence in a
> single pack.

What I meant to say was not "it is in this pack and nowhere else", but
about a check like this:

        static void finish_object(struct object *obj, ...)
        {
                struct packed_git *fetched_pack = cb_data->fetched_pack;

                if (obj->type == OBJ_BLOB && !has_sha1_file(obj->sha1))
                        die("missing");
                if (!info->revs->verify_objects)
                        return;
		if (find_pack_entry_one(obj->sha1, fetched_pack))
                        return; /* we just fetched and ran index-pack on it */
                if (!obj->parsed && obj->type != OBJ_COMMIT)
                        parse_object(obj->sha1);                
        }

I think this is the kind of "passing identity down the callchain" both of
us have in mind.  I was trying to say that find_pack_entry() may not be
trivially cheap.  But probably I am being worried too much.

But now you brought it up, I think we may also need to worry about a
corrupt pre-existing loose blob object.  In general, we tend to always
favor reading objects from packs over loose objects, but I do not know
offhand what repacking would do when there are two places it can read the
same object from (it should be allowed to pick whichever is easier to
read).
