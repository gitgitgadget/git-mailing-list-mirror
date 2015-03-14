From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 01/10] Define a structure for object IDs.
Date: Sat, 14 Mar 2015 18:49:51 +0700
Message-ID: <CACsJy8BeFO3RQJ6pU5+q6E4n3A36X9PgYoi7xB_NQ4C_JYaP5w@mail.gmail.com>
References: <1425770645-628957-1-git-send-email-sandals@crustytoothpaste.net>
 <1425770645-628957-2-git-send-email-sandals@crustytoothpaste.net>
 <CEA07500-9F47-4B24-AD5D-1423A601A4DD@gmail.com> <20150311220825.GB46326@vauxhall.crustytoothpaste.net>
 <xmqqr3sv3vsf.fsf@gitster.dls.corp.google.com> <55016A3A.6010100@alum.mit.edu>
 <20150312104651.GF46326@vauxhall.crustytoothpaste.net> <CACsJy8AL0jGwzTfWDSszkvyqzNtPA7o7vQRT5NFaBYrVU02nOA@mail.gmail.com>
 <xmqqwq2m2hwf.fsf@gitster.dls.corp.google.com> <CACsJy8CMZbwyBayX-bbWmGwV=AWC000Yx6LfzOcB2irq2X6qHQ@mail.gmail.com>
 <xmqqwq2lzb6u.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	"Kyle J. McKay" <mackyle@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Andreas Schwab <schwab@linux-m68k.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 14 12:50:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YWkaL-0000m6-EL
	for gcvg-git-2@plane.gmane.org; Sat, 14 Mar 2015 12:50:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753587AbbCNLuY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Mar 2015 07:50:24 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:32970 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751469AbbCNLuW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Mar 2015 07:50:22 -0400
Received: by ignm3 with SMTP id m3so5346300ign.0
        for <git@vger.kernel.org>; Sat, 14 Mar 2015 04:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=toSEJxgFxyOJByLwLTGUxukaUTidtakdtKX241nGmpg=;
        b=pXHOkcfqIMf61r3W7a703Vx666zN/zK0g2Y1gFohx77fxYFggv4ti8J+6KvOsgdlig
         ObOGSlQvGhQlxnz3qw1duY7QhNJKPCxb971qpa59M7plZDhAs2aVxCy7mrMj3kbXtgtf
         zZGbN5yVGfxUZOwpfi1rwJcqVW7RSnfzQuSvx6JZ8GaqCsuPMgQ9vZeSfQZN+5BQAHLJ
         xl1K1g2mxtUwXY+E5iVMNVVNKudkFEbxC6wWLP1X+ZiIk5+jIruAXRMMwkvv/xNEUTzk
         0l1R2YHgyVmysu5ev6PaMNr3Z1TwUzlfoIkO/4quN1HtR+T/anmrY6r90kvZKGuw573d
         43ug==
X-Received: by 10.50.79.161 with SMTP id k1mr91596204igx.14.1426333821984;
 Sat, 14 Mar 2015 04:50:21 -0700 (PDT)
Received: by 10.107.131.33 with HTTP; Sat, 14 Mar 2015 04:49:51 -0700 (PDT)
In-Reply-To: <xmqqwq2lzb6u.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265448>

On Fri, Mar 13, 2015 at 1:03 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> To me, <pack, offset> information smells to belong more to a "struct
>>> object" (or its subclass) as an optional annotation---when a caller
>>> is asked to parse_object(), you would bypass the sha1_read_file()
>>> that goes and looks the object name up from the list of pack .idx
>>> and instead go there straight using that annotation.
>>
>> For pack v4, commits and trees can be encoded this way.
>
> Even if your in-pack representation of a commit object allowed to
> store the tree pointer in <pack, nth> format, its object name must
> be computed as if you have the commit object in the traditional
> format and computed the hash of that (together with the standard
> "<type> <size>\0" header), and at that point, you need the contained
> object's name in <sha-1> format (imagine how you would implement the
> commit-tree command).

True. But commit-tree is not often executed as, say, rev-list, where
the hash is used as 20-byte key to some pieces somewhere (pack data,
struct object *). If we keep <pack, nth> in object_id (the union
approach), v4-aware code has the chance to go on a fast path.

> Hence, I do not think the v4 encoding changes
> the discussion very much.  I see the primary value of v4 encoding is
> to shorten the length of various fields take on-disk and in-pack.
> If it were <pack, offset>, it could be argued that it would also be
> faster to get to the packed data in the packfile, and going from
> <pack, nth> to the .idx file and then going to the location in the
> data in the packfile would be faster than going from <sha-1> to a
> particular pack and its in-pack offset, with the difference of cost
> around log(n)*m where n is the number of objects in a pack and m is
> the total number of packs in the repository.
>
> It is true that <nth> format (force that the referred-to object
> lives in the same pack as the referrer) can help speed up
> interpretation of extended SHA-1 expression, e.g. "v1.0^0:t", which
> can read v1.0 tag in v4 format, find the <nth> info for the commit
> pointed by the tag and get to that data in the pack, find the <nth>
> info for the top-tree recorded in that commit and directly get to
> the data of that tree, and then find the entry for "t", which will
> give the object name for that subtree again in <nth> format, and at
> that point you can find the <sha-1> of that final object, without
> having to know any object names of the intermediate objects
> (i.e. you must start from <sha-1> of the tag you obtain from the
> refs API, but you didn't use the object name of the commit and its
> top-level tree).  So for such a codepath, I would say it would be
> sufficient to use a "union in struct" people have been envisioning
> and convert <pack, nth> to <sha-1> when the latter form becomes
> necessary for the first time for the object.

It's the point: faster access (to either pack data, or "struct object
*"). Using a separate union from  struct object_id (iow, object_id
only contains SHA-1) works. But imagine to independent code islands
can perform this type of fast access. In order to pass this union from
one island to another, we need to update pretty much every function
call between them. The change to using object_id has a similar impact.
If we go with "union in object_id", we may be able to avoid the second
mass change to make use of <pack, nth>.

> Anyway, wouldn't this be all academic?  I do not see how you would
> keep the object name in the <pack, nth> format in-core, as the
> obj_hash[] is a hashtable keyed by <sha-1>, and even when we switch
> to a different hash, I cannot see how such a table to ensure the
> singleton-ness of in-core objects can be keyed sometimes by <hash>
> and by <pack, nth> in some other time.

I'm implementing something to see how much we gain by avoiding object
lookup. The current approach is having "struct object ** obj" in
"struct packed_git", indexed by "nth". So when you have <pack, nth>
and pack->obj[nth] is valid, you'll get to "struct object *" without
hashing. If pack->obj[nth] is NULL, hashing and looking up are
required the first time using SHA-1, then the result is cached in
pack->obj[]. So no, it's not academic :)
-- 
Duy
