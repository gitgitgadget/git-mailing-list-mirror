From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 01/10] Define a structure for object IDs.
Date: Fri, 13 Mar 2015 07:58:20 +0700
Message-ID: <CACsJy8CMZbwyBayX-bbWmGwV=AWC000Yx6LfzOcB2irq2X6qHQ@mail.gmail.com>
References: <1425770645-628957-1-git-send-email-sandals@crustytoothpaste.net>
 <1425770645-628957-2-git-send-email-sandals@crustytoothpaste.net>
 <CEA07500-9F47-4B24-AD5D-1423A601A4DD@gmail.com> <20150311220825.GB46326@vauxhall.crustytoothpaste.net>
 <xmqqr3sv3vsf.fsf@gitster.dls.corp.google.com> <55016A3A.6010100@alum.mit.edu>
 <20150312104651.GF46326@vauxhall.crustytoothpaste.net> <CACsJy8AL0jGwzTfWDSszkvyqzNtPA7o7vQRT5NFaBYrVU02nOA@mail.gmail.com>
 <xmqqwq2m2hwf.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	"Kyle J. McKay" <mackyle@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Andreas Schwab <schwab@linux-m68k.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 13 01:58:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YWDwG-0005yT-S0
	for gcvg-git-2@plane.gmane.org; Fri, 13 Mar 2015 01:58:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754093AbbCMA6w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2015 20:58:52 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:33860 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754068AbbCMA6v (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2015 20:58:51 -0400
Received: by iecsl2 with SMTP id sl2so71341378iec.1
        for <git@vger.kernel.org>; Thu, 12 Mar 2015 17:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=za/C9Bprk0/0ke+BTdU+0VFEvMhvVyT380swVePXfoE=;
        b=WLidITeB4bJ2WWokq6ZlZSCTO0xfuF6N1QOw79bus89gtntyXgdhjxtvd7nS1SOqVa
         8elLyTiZOg64ZGwJDAk/rL3OoZY1BXU6H3QtvsKsWEasN2W+R01s5b36uJZ2JCcPlx78
         9rRNFqbQMuGWLuXogwt6HCIo9S01ojoiFCftJ8PI+1wvVa0iACmxkos9XGXx13OVAIYM
         jsJAIo9UnyKxzCEUlChucmJhkksJwYdkHkL2YXOh/nJh3eM3HX6dFE0UuYWVD8QIcR+p
         tmv2t7Jndo2aDjpDYJjr08AGlIb6oD/JbpBtODQI347N6y72ZBffw+zjDJultUhGI8xk
         18yw==
X-Received: by 10.50.111.202 with SMTP id ik10mr79355101igb.37.1426208330457;
 Thu, 12 Mar 2015 17:58:50 -0700 (PDT)
Received: by 10.107.131.33 with HTTP; Thu, 12 Mar 2015 17:58:20 -0700 (PDT)
In-Reply-To: <xmqqwq2m2hwf.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265385>

On Fri, Mar 13, 2015 at 1:24 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> This may or may not fall into the "mix different hash functions"
>> category. In pack files version 4, trees are encoded to point to other
>> trees or blobs by a (pack, offset) tuple. It would be great if the new
>> object_id could support carrying this kind of object id around because
>> it could help reduce object lookup cost a lot. (pack, offset) can be
>> converted back to SHA-1 so no info is lost and hashcmp() can compare
>> (pack, tuple) against an SHA-1 just fine.
>
> You mean "if it came in <pack, offset> format, convert it down to
> <sha1> until the last second that it is needed (e.g. need to put
> that in a tree object in order to compute the object name of the
> containing tree object)"?

I picked my words poorly. It should be <pack, the index in pack>
instead of the _byte_ offset. This index ranges from 0 to the number
of objects minus one. This is essentially what pack v4 stores in
places where pack v2 would store SHA-1, which makes me make the
connection: both are different ways of identifying an object.

> After converting an object name originally represented as <pack,
> offset>, if we are doing the "union in struct" thing, to <sha1>
> representation, you would have to look it up from .idx in order to
> read the contents the usual way.  If that happens often enough, then
> it may not be worth adding complexity to the code to carry the
> <pack, offset> pair around.

I'd keep it in <pack, index> for as long as possible (or until higher
layer decides that it's not worth keeping in this representation
anymore). I can only see two use cases where actual SHA-1 is involved:
sorting by SHA-1 (rarely done, probably only in index-pack and
pack-objects) and output to the screen (or producing v2 packs).

> Unless you fix that "union in struct" assumption, that is.
>
> To me, <pack, offset> information smells to belong more to a "struct
> object" (or its subclass) as an optional annotation---when a caller
> is asked to parse_object(), you would bypass the sha1_read_file()
> that goes and looks the object name up from the list of pack .idx
> and instead go there straight using that annotation.

For pack v4, commits and trees can be encoded this way. parse_object()
could help the commit case (maybe, maybe not, I haven't looked at
commit walkers), not recursive tree walking where we now pass SHA-1
around to user callback and all. Carrying optional annotation around
would impact the code in many places.  Also, storing this info in
struct object seems conflict with v4 goal of reducing "struct object"
lookup cost.  Maybe I'm missing something here.

Then again, we don't know if pack v4 will get merged in the end (I do
hope it will). And we have an option of making specialized commit/tree
walkers that are aware of pack v4 and only use them in hot places to
reduce impact to the rest of the code base. If hash[GIT_MAX_RAWSZ]
looks like a good enough solution, we can go with that and worry about
pack v4 later when/if it comes.
-- 
Duy
