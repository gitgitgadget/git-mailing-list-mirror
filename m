From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] notes get-ref: --expand expands the output notes
 ref.
Date: Thu, 06 Sep 2012 12:47:10 -0700
Message-ID: <7vr4qf2atd.fsf@alter.siamese.dyndns.org>
References: <cover.1346848834.git.wking@tremily.us>
 <4eea4f3eab8ee827a40802a50aa2cda9e4b43943.1346849556.git.wking@tremily.us>
 <CALKQrgem2KM07vA0LeVgD6HkM1yMDBSfThKUZ7aBaxpbcC49hA@mail.gmail.com>
 <7v4nnb67x1.fsf@alter.siamese.dyndns.org>
 <20120906061147.GA11770@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johan Herland <johan@herland.net>, Git <git@vger.kernel.org>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Thu Sep 06 21:47:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9i3F-0001WG-Qd
	for gcvg-git-2@plane.gmane.org; Thu, 06 Sep 2012 21:47:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759537Ab2IFTrO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Sep 2012 15:47:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53339 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758690Ab2IFTrN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2012 15:47:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6DE6B9A02;
	Thu,  6 Sep 2012 15:47:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wIOv8MjtDZVUkR2dgWOcGNYfs/k=; b=vlReVu
	NaGNwdqQw3up4EsPLCQ++dtKDyUlHPSXaJhF8ofTWpvZT0UCMVR6udzKwfNWALuT
	UyzDW0/n19abI5Y+BbyK74IDyGBp7usJTkgr1eK2H/SNz6nDJ54pPrlinRsY6WmM
	r1RcJfxR9K5tmSDHlO5RgAX1rQkm7jbxecXx0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SmEjJhqubNSZPKsFV3Nu28WkcDUbSZiS
	3FTBG60oczYEOwr6QEnuhrF0tMcWsZFBOAS1bOdm7iMsHhPGHnJZqviCbIc8XoK5
	JnY0ofzSGYX3sQj6VpthpNxiCye3dPb7A9RLsXWOxxhUu19r588L6mVtQ0zlyGZV
	lLgC4iDGNww=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5A4519A00;
	Thu,  6 Sep 2012 15:47:12 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B439D99FE; Thu,  6 Sep 2012
 15:47:11 -0400 (EDT)
In-Reply-To: <20120906061147.GA11770@odin.tremily.us> (W. Trevor King's
 message of "Thu, 06 Sep 2012 02:11:48 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A687F162-F85B-11E1-BE63-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204916>

"W. Trevor King" <wking@tremily.us> writes:

> On Wed, Sep 05, 2012 at 10:23:54PM -0700, Junio C Hamano wrote:
>> Really?  Would "git log --expand master" be useful?
>
> I'm clearly not an expert on this, but isn't that what
>
>   git show-ref master
>
> is for?

But then can't you say the same against "git notes get-ref --expand"
with "git show-ref refs/remotes/origin/notes/foobla"?

My primary point is that I think it is a UI mistake if the DWIM
ignores the user input that directly names that can be interpreted
without DWIMming.  When the user wants to avoid ambiguity, it should
always be possible to spell it out without having to worry about the
DWIM code to get in the way.

The problem with the current notes.c:expand_notes_ref() is that it
does not allow you to do that, and if you fixed that problem, the
user never has to ask "what does this expand to", no?

Perhaps something like this.  Note that this only deals with an
existing ref, and that is semi-deliberate (because I am not yet
convinced that it is a good idea to let any ref outside refs/notes/
to be created to hold a notes tree).

 notes.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git i/notes.c w/notes.c
index 93e9868..126839e 100644
--- i/notes.c
+++ w/notes.c
@@ -1289,6 +1289,8 @@ int copy_note(struct notes_tree *t,
 
 void expand_notes_ref(struct strbuf *sb)
 {
+	if (!prefixcmp(sb->buf, "refs/") && ref_exists(sb->buf))
+		return;
 	if (!prefixcmp(sb->buf, "refs/notes/"))
 		return; /* we're happy */
 	else if (!prefixcmp(sb->buf, "notes/"))
