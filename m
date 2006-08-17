From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] introduce inline is_same_sha1
Date: Wed, 16 Aug 2006 18:12:17 -0700
Message-ID: <7vveos17ym.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0608161721020.11465@chino.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 17 03:12:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDWQz-0004tU-Gd
	for gcvg-git@gmane.org; Thu, 17 Aug 2006 03:12:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932172AbWHQBMT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Aug 2006 21:12:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932175AbWHQBMT
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Aug 2006 21:12:19 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:4750 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932172AbWHQBMS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Aug 2006 21:12:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060817011217.ZMQR554.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 16 Aug 2006 21:12:17 -0400
To: David Rientjes <rientjes@google.com>
In-Reply-To: <Pine.LNX.4.63.0608161721020.11465@chino.corp.google.com> (David
	Rientjes's message of "Wed, 16 Aug 2006 17:25:30 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25541>

David Rientjes <rientjes@google.com> writes:

> Introduces global inline:
> 	is_same_sha1(const unsigned char *sha1,
> 		     const unsigned char *sha2);
>
> Uses memcmp for comparison and returns the result.  All tests
> for comparisons for sha1 have been changed to use the new
> global inline, but existing uses of memcmp have been preserved
> where the return value other than 0 is needed, i.e.:
>
> 	int cmp = !memcmp(old_sha1, new_sha1, 20);
>
> Conversions from char* to unsigned char* casts have been made
> where appropriate.
>
> Signed-off-by: David Rientjes <rientjes@google.com>

I would have expected the inline function to be:

	int cmp_object_name(const void *, const void *)

No need for "unsigned char *" that way [*1*].  

I do not know what your ultimate goal with this patch is, but I
like the fact that we do not have to hardcode "20" everywhere.
With a yet-to-be-written companion patch to make the "20" into a
symbolic constant OBJECT_NAME_LENGTH, we could someday have a
flag day to use a hash different from SHA-1 with an updated
'git-convert-objects' ;-).

I would have liked if the function were to give the comparison
results similar to standard comparison functions such as memcmp
and strcmp.  I do not know off-hand if we order by the object
names, and we might only be interested in equality tests, but
still...

Line-wrap the message for comfortable viewing on 80-column
terminals, please.

[Footnote]

*1* On the other hand if stricter type checking is wanted,
    "const unsigned char *" is too weak.  We would need either
    sparse annotation or a new type (maybe a struct that has a
    single member that has 20-byte uchar array).  I personally
    think that is an overkill, though.
