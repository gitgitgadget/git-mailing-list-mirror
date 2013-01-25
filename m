From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: segmentation fault (nullpointer) with git log --submodule -p
Date: Fri, 25 Jan 2013 09:05:45 +0700
Message-ID: <CACsJy8AS3cgF3LXzkXh3JyBpv7xY=Lf4T=sXK1EELU-j+VkUhQ@mail.gmail.com>
References: <20130123143816.GA579@krypton.darkbyte.org> <20130123200222.GB19832@sigill.intra.peff.net>
 <510124F5.9090505@atlas-elektronik.com> <CACsJy8B9O=A26_=sv1JEYdtazsWa4khZkqpTgFSSTs_RGGPZqQ@mail.gmail.com>
 <51013FDD.5030004@atlas-elektronik.com> <CACsJy8CEofqi9S8-SDx_O+Ko0i56aRZ4KEJrVnbFum6zzsJrJg@mail.gmail.com>
 <20130124232721.GA16036@sigill.intra.peff.net> <7va9ry87a0.fsf@alter.siamese.dyndns.org>
 <20130125005528.GA27325@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?U3RlZmFuIE7DpHdl?= <stefan.naewe@atlas-elektronik.com>,
	Armin <netzverweigerer@gmail.com>, Jonathon Mah <jmah@me.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 25 03:06:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyYgg-0002nf-09
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 03:06:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755243Ab3AYCGR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2013 21:06:17 -0500
Received: from mail-ob0-f180.google.com ([209.85.214.180]:49173 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755331Ab3AYCGP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2013 21:06:15 -0500
Received: by mail-ob0-f180.google.com with SMTP id ef5so416783obb.39
        for <git@vger.kernel.org>; Thu, 24 Jan 2013 18:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=tupd2RVxj3bHMJKmsMCfrmudxRao/CnKUTgy2KAv5LY=;
        b=wh4/RM5FAemqxQQKcWL8zHbdVNQ0TSvHxBl82pUKLNcB58ByKGuP12YIz4sCweZvUp
         +GgAsXDfEUr2ti6eY/bIW3QLRFdHmNxFopxLagVQlXp+EqTlgu8dDf9GtD0JC37wZ7Dg
         SdW6D6LPJ/UAGpLnak2ISCxt8nZ9ucUXBhcrMJy7JJKHz6y3XpGvvoRlM4z8ZQsKTv0E
         zTl/PsT/pvUE4QDuQ7HQQvEMS/uomiP1/pELXwHqWHAAkzYnM+NKTnTfIrsFsWQ4owSg
         GCW79+MRFqWrM1p3uvvKqpL3wfTn3xydLbBAZDIku6jYvRIXRRuE7lQe4sD0xuv8tYdH
         +7Pw==
X-Received: by 10.182.2.132 with SMTP id 4mr3304276obu.42.1359079575236; Thu,
 24 Jan 2013 18:06:15 -0800 (PST)
Received: by 10.182.153.69 with HTTP; Thu, 24 Jan 2013 18:05:45 -0800 (PST)
In-Reply-To: <20130125005528.GA27325@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214480>

On Fri, Jan 25, 2013 at 7:55 AM, Jeff King <peff@peff.net> wrote:
> On Thu, Jan 24, 2013 at 03:56:23PM -0800, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>>
>> > ... (e.g., how should "log" know that a submodule diff might later want
>> > to see the same entry? Should we optimistically free and then make it
>> > easier for the later user to reliably ensure the buffer is primed? Or
>> > should we err on the side of keeping it in place?).
>>
>> My knee-jerk reaction is that we should consider that commit->buffer
>> belongs to the revision traversal machinery.  Any other uses bolted
>> on later can borrow it if buffer still exists (I do not think pretty
>> code rewrites the buffer contents in place in any way), or they can
>> ask read_sha1_file() to read it themselves and free when they are
>> done.
>
> Yeah, that is probably the sanest way forward. It at least leaves
> ownership in one place, and everybody else is an opportunistic consumer.
> We do need to annotate each user site though with something like the
> "ensure" function I mentioned.
>
> If they are not owners, then the better pattern is probably something
> like:

You probably should rename "buffer" (to _buffer or something) and let
the compiler catches all the places commit->buffer illegally used.

>
>   /*
>    * Get the commit buffer, either opportunistically using
>    * the cached version attached to the commit object, or loading it
>    * from disk if necessary.
>    */
>   const char *use_commit_buffer(struct commit *c)
>   {
>           enum object_type type;
>           unsigned long size;
>
>           if (c->buffer)
>                   return c->buffer;
>           /*
>            * XXX check type == OBJ_COMMIT?
>            * XXX die() on NULL as a convenience to callers?
>            */
>           return read_sha1_file(c->object.sha1, &type, &size);
>   }
>
>   void unuse_commit_buffer(const char *buf, struct commit *c)
>   {
>           /*
>            * If we used the cached copy attached to the commit,
>            * we don't want to free it; it's not our responsibility.
>            */
>           if (buf == c->buffer)
>                   return;
>
>           free((char *)buf);
>   }
>
> I suspect that putting a use/unuse pair inside format_commit_message
> would handle most cases.
>
> -Peff
-- 
Duy
