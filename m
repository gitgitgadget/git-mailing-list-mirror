From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v5 01/14] Add data structures and basic functions for
 commit trailers
Date: Sun, 09 Feb 2014 14:48:09 +0100 (CET)
Message-ID: <20140209.144809.1747063529382396154.chriscool@tuxfamily.org>
References: <20140206194123.325.99451.chriscool@tuxfamily.org>
	<20140206202004.325.80557.chriscool@tuxfamily.org>
	<xmqqzjm3x0v3.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, johan@herland.net, josh@joshtriplett.org,
	tr@thomasrast.ch, mhagger@alum.mit.edu, sunshine@sunshineco.com,
	dan.carpenter@oracle.com, greg@kroah.com, peff@peff.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Feb 09 14:48:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WCUkV-0003mY-9J
	for gcvg-git-2@plane.gmane.org; Sun, 09 Feb 2014 14:48:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751396AbaBINsO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Feb 2014 08:48:14 -0500
Received: from mail-2y.bbox.fr ([194.158.98.15]:32971 "EHLO mail-2y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751360AbaBINsN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Feb 2014 08:48:13 -0500
Received: from localhost (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id 81C6738;
	Sun,  9 Feb 2014 14:48:09 +0100 (CET)
In-Reply-To: <xmqqzjm3x0v3.fsf@gitster.dls.corp.google.com>
X-Mailer: Mew version 6.3 on Emacs 23.3 / Mule 6.0 (HANACHIRUSATO)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241874>

From: Junio C Hamano <gitster@pobox.com>
>
> Christian Couder <chriscool@tuxfamily.org> writes:
> 
>> +enum action_where { WHERE_AFTER, WHERE_BEFORE };
>> +enum action_if_exist { EXIST_ADD_IF_DIFFERENT, EXIST_ADD_IF_DIFFERENT_NEIGHBOR,
>> +		       EXIST_ADD, EXIST_OVERWRITE, EXIST_DO_NOTHING };
>> +enum action_if_missing { MISSING_ADD, MISSING_DO_NOTHING };
> 
> All these names and "conf_info" below are not named to be specific
> to this little tool.  Can I assume that these will never be exposed
> to the rest of the system?  If so, they are fine.

Yeah, I don't plan them to be exposed to other files.
 
>> +struct conf_info {
>> +	char *name;
>> +	char *key;
>> +	char *command;
>> +	enum action_where where;
>> +	enum action_if_exist if_exist;
>> +	enum action_if_missing if_missing;
> 
> It still feels somewhat strange.  It is true that an item can be
> either "exist" or "missing" and it is understandable that it tempts
> you to split that into two, but EXIST_OVERWRITE will not trigger
> either WHERE_AFTER or WHERE_BEFORE action.

Yeah, it's true that WHERE_AFTER/WHERE_BEFORE does not make sense for
EXIST_OVERWRITE, EXIST_DO_NOTHING and MISSING_DO_NOTHING, but it's a
fact of life that sometimes some options do not make sense with
others.

>> +static inline int same_token(struct trailer_item *a, struct trailer_item *b, int alnum_len)
>> +{
>> +	return !strncasecmp(a->token, b->token, alnum_len);
>> +}
>> +
>> +static inline int same_value(struct trailer_item *a, struct trailer_item *b)
>> +{
>> +	return !strcasecmp(a->value, b->value);
>> +}
>> +
>> +static inline int same_trailer(struct trailer_item *a, struct trailer_item *b, int alnum_len)
>> +{
>> +	return same_token(a, b, alnum_len) && same_value(a, b);
>> +}
> 
> All these "inlines" look premature optimization that can be
> delegated to any decent compiler, don't they?

Yeah, but as Eric suggested to add them like in header files and you
did not reply to him, I thought you agreed with him.
I will remove them.

>> +/* Get the length of buf from its beginning until its last alphanumeric character */
>> +static inline size_t alnum_len(const char *buf, int len)
>> +{
>> +	while (--len >= 0 && !isalnum(buf[len]));
> 
> Style:
> 
> 	while (--len >= 0 && !isalnum(buf[len]))
>         	;
> 
> You may add a comment on the empty statement to make it stand out
> even more, i.e.
> 
> 		; /* nothing */

Ok, I will do that.

>> +	return (size_t) len + 1;
> 
> This is somewhat unfortunate.  if the caller wants to receive
> size_t, perhaps it should be passing in size_t (or ssize_t) to the
> function?  Hard to guess without an actual caller, though.

Ok, I will make it return an int.

Thanks,
Christian.
