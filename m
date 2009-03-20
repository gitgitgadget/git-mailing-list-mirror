From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git Large Object Support Proposal
Date: Thu, 19 Mar 2009 17:41:43 -0700
Message-ID: <7vk56l58l4.fsf@gitster.siamese.dyndns.org>
References: <d411cc4a0903191514n1e524ebava5895d708a2927c4@mail.gmail.com>
 <7veiwt6t6a.fsf@gitster.siamese.dyndns.org>
 <d411cc4a0903191618x503db946n62d3132eece69175@mail.gmail.com>
 <7vzlfh5b7y.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 20 01:43:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkSpU-0002Rw-Af
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 01:43:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757843AbZCTAlv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 20:41:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755992AbZCTAlv
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 20:41:51 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52955 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754455AbZCTAlu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 20:41:50 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 247E6A3AE0;
	Thu, 19 Mar 2009 20:41:48 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E64E3A3ADF; Thu,
 19 Mar 2009 20:41:44 -0400 (EDT)
In-Reply-To: <7vzlfh5b7y.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 19 Mar 2009 16:44:49 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E516CC92-14E7-11DE-8B58-32B0EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113877>

Junio C Hamano <gitster@pobox.com> writes:

> Scott Chacon <schacon@gmail.com> writes:
>
>> The point is that we don't keep this data as 'blob's - we don't try to
>> compress them or add the header to them, they're too big and already
>> compressed, it's a waste of time and often outside the memory
>> tolerance of many systems. We keep only the stub in our db and stream
>> the large media content directly to and from disk.  If we do a
>> 'checkout' or something that would switch it out, we could store the
>> data in '.git/media' or the equivalent until it's uploaded elsewhere.
>
> Aha, that sounds like you can just maintain a set of out-of-tree symbolic
> links that you keep track of, and let other people (e.g. rsync) deal with
> the complexity of managing that side of the world.
>
> And I think you can start experimenting it without any change to the core
> datastructures.  In your single-page web site in which its sole html file
> embeds an mpeg movie, you keep track of these two things in git:
>
> 	porn-of-the-day.html
>       porn-of-the-day.mpg -> ../media/6066f5ae75ec.mpg
>
> and any time you want to feed a new movie, you update the symlink to a
> different one that lives outside the source-controlled tree, while
> arranging the link target to be updated out-of-band.

I wasn't thinking clearly.

This is not really a new "huge blob" type but is just a slightly different
flavor of symbolic link.  Its link target name may resemble SHA-1 object
name, but it does not participate in the reachability computation.  it
won't be fetched nor pushed, and if you ever get one via the usual git
codepath into your object store, it will be subject to "git gc", but you
are unlikely to place it inside your object store to begin with.  You have
something like:

    100644 2222222222222222222222222222222222222222 porn-of-the-day.html
    120001 5ed22400803161de2f49331d005be424b7f6d036 porn-of-the-day.mpg

where 5ed22400803161de2f49331d005be424b7f6d036 is a blob that stores the
name of a regular blob object, 6ff87c4664981e4397625791c8ea3bbb5f2279a3,
in your tree object (and in the index), and:

 * When running "git media", you have a configuration to tell it where the
   external media files are kept (e.g. ../media in the previous example),
   and it rsyncs to ../media/6ff87c4664981e4397625791c8ea3bbb5f2279a3 in
   some unspecified way from some unspecified place;

 * When checking out porn-of-the-day.mpg, it becomes a symbolic link that
   points at ../media/6ff87c4664981e4397625791c8ea3bbb5f2279a3 (because it
   follows the same site-specific configuration);

 * When comparing the index (that records the 120001 "slightly different
   symbolic link" entry with the shell blob object) and the work tree
   (that has a symbolic link that points at ../media/6ff87c46649...), you
   do not look at the contents of the ../media/6ff87c46649... file, but
   you do look at its name, apply a reverse of the mapping "checkout"
   codepath did to arrive at 6ff87c4664981e4397625791c8ea3bbb5f2279a3
   SHA-1, compare that with what the shell blob object records.  If you
   updated the symbolic link in the work tree, "git add" would result in
   creating a new shell object (just like when you change the link target
   for a normal symbolic link) that records the external blob.

It still is bothersome that we need to introduce a new tree nodetype
(rather, a new blob subtype similar to "regular file blob", "symlink
blob"), but it is of much less impact than what I originally
misunderstood.

Having said that, if that is what is happening, I do not see the need for
the payload to be even a blob SHA-1 name.  Any identifier that is
convenient to generate in the application domain could do.

But that is a minor detail that immediately popped at me; there may be
other minor details I may find objectionable later.  But overall, I think
your proposal makes sense.

I still think a large part of preliminary experiments to see the benefit
of this approach can and should be done without and before touching the
core part (like introduction of the slightly different symlink 1200001
mode), though.
