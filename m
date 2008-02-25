From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] add generic, type aware object chain walker
Date: Sun, 24 Feb 2008 23:37:25 -0800
Message-ID: <7vwsotmqq2.fsf@gitster.siamese.dyndns.org>
References: <12038642373342-git-send-email-mkoegler@auto.tuwien.ac.at>
 <20080225030404.GL8410@spearce.org>
 <20080225072658.GB15761@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: mkoegler@auto.tuwien.ac.at (Martin Koegler)
X-From: git-owner@vger.kernel.org Mon Feb 25 08:38:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTXug-0004d0-Cc
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 08:38:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751825AbYBYHhi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2008 02:37:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751626AbYBYHhi
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 02:37:38 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:39893 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750909AbYBYHhh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2008 02:37:37 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 786C114F3;
	Mon, 25 Feb 2008 02:37:34 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 68E6314F2; Mon, 25 Feb 2008 02:37:28 -0500 (EST)
In-Reply-To: <20080225072658.GB15761@auto.tuwien.ac.at> (Martin Koegler's
 message of "Mon, 25 Feb 2008 08:26:58 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75001>

mkoegler@auto.tuwien.ac.at (Martin Koegler) writes:

> On Sun, Feb 24, 2008 at 10:04:04PM -0500, Shawn O. Pearce wrote:
>> Martin Koegler <mkoegler@auto.tuwien.ac.at> wrote:
>> Hmm.  Don't you need to get commit->parenst *after* it is parsed,
>> and not before?
>
> Thanks, fixed.
>
>> > @@ -0,0 +1,10 @@
>> > +#ifndef GIT_FSCK_H
>> > +#define GIT_FSCK_H
>> > +
>> > +#define OBJ_ANY OBJ_BAD
>> 
>> Its unclear why this macro is necessary.
>
> There are cases (eg. a tag->tagged), where the object type does not
> matter. In this case, the callback gets this value for the expected
> type.
>
> The value of OBJ_BAD (-1) is not used anywhere in git, so its
> free. OBJ_ANY is just a better name.
>
> If somebody has a better idea, please tell me.

As I mentioned in my previous review comment, the token is used
to tell the walker callback function that this type of object
was expected where it was found, in order to allow the callback
to check the type of the object.  I think OBJ_ANY is a very good
name for the token you would use to tell the callback that any
type of object can appear (because that is a taggee).

So I do not have objection to OBJ_ANY (but again, this kind of
thing needs to be explained in your commit log message), but
giving the token the same value as OBJ_BAD may not be such a
cool idea.  After all, if the walker callback was told with
OBJ_ANY that any type of object is Ok, it should still say
"oops" if the given object said it actually is of type OBJ_BAD.
E.g. in your [2/4] patch:

        +static int mark_object(struct object *obj, int type, void *data)
        +{
        + ...
        +	if (type != OBJ_ANY && obj->type != type) {
        +		objerror(parent, "wrong object type in link");
        +	}

if you use the above #define, a tagged object that has a bad
type will pass this check unnoticed, won't it?
