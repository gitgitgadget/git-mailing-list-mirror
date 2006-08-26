From: Junio C Hamano <junkio@cox.net>
Subject: Re: Problem with pack
Date: Sat, 26 Aug 2006 03:09:13 -0700
Message-ID: <7vu03z3j1y.fsf@assigned-by-dhcp.cox.net>
References: <44EECBE2.7090801@arces.unibo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sergio Callegari <scallegari@arces.unibo.it>,
	Nicolas Pitre <nico@cam.org>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sat Aug 26 12:09:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GGv6S-0008Ga-P8
	for gcvg-git@gmane.org; Sat, 26 Aug 2006 12:09:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751107AbWHZKI5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 Aug 2006 06:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751049AbWHZKI5
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Aug 2006 06:08:57 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:33475 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751099AbWHZKI4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Aug 2006 06:08:56 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060826100855.MQCD21457.fed1rmmtao07.cox.net@fed1rmimpo01.cox.net>;
          Sat, 26 Aug 2006 06:08:55 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
	by fed1rmimpo01.cox.net with bizsmtp
	id Ea8t1V01h4Noztg0000000
	Sat, 26 Aug 2006 06:08:54 -0400
To: git@vger.kernel.org
In-Reply-To: <44EECBE2.7090801@arces.unibo.it> (Sergio Callegari's message of
	"Fri, 25 Aug 2006 12:07:30 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26042>

Sergio Callegari <scallegari@arces.unibo.it> writes:

> I was not expecting this kind of problem, so I silly did a repack as
> the last thing, I went home, I attached the laptop to the net, I run
> unison, I started to work and I realized that there was a problem when
> I attempted a new repack which failed complaining about the corrupted
> pack...

Sorry about the mixed "intended audience" of this message,
asking Sergio for a bit more info as the end user who had
problems with git, and at the same time describing the code
level analysis of possible cause to ask for help from git
developers.  Nico CC'ed because he seems to be the person who
knows the best around this area including zlib.

- - -

Earlier you said that the mothership has 1.4.2, and the note has
1.4.0.  The sequence of events as I understand are:

	- repack -a -d on the mothership with 1.4.2; no problems
          observed.

        - transfer the results to note; this was done behind git so
          no problems observed.

        - tried to repack on note with 1.4.0; got "failed to
          read delta-pack base object" error.

Can you make the pack/idx available to the public for
postmortem?

Also I wonder if the pack can be read by 1.4.2.

Earlier you said "unpack-objects <$that-pack.pack" fails with
"error code -3 in inflate..."  What exact error do you get?
I am guessing that it is get_data() which says:

	"inflate returned %d\n"

(side note: we should not say \n there).

        static void *get_data(unsigned long size)
        {
                z_stream stream;
                void *buf = xmalloc(size);

                memset(&stream, 0, sizeof(stream));

                stream.next_out = buf;
                stream.avail_out = size;
                stream.next_in = fill(1);
                stream.avail_in = len;
                inflateInit(&stream);

                for (;;) {
                        int ret = inflate(&stream, 0);
                        use(len - stream.avail_in);
                        if (stream.total_out == size && ret == Z_STREAM_END)
                                break;
                        if (ret != Z_OK)
                                die("inflate returned %d\n", ret);
                        stream.next_in = fill(1);
                        stream.avail_in = len;
                }
                inflateEnd(&stream);
                return buf;
        }

This pattern appears practically everywhere.  When inflate()
returns, we expect its return value to be either Z_OK or
Z_STREAM_END and everything else is treated as an error.  Also
when we receive Z_STREAM_END the resulting length had better be
the size we expect.  I do not have any problem with the latter
but have always felt uneasy about the former but being no zlib
expert had been using the code as is.  zlib.h says Z_BUF_ERROR
is not fatal -- it just means this round of call with the given
input and output buffer did not make any progress.  I've been
wondering if it is possible for inflate to eat some input but
that was not enough to produce one byte of output, and what
would return in such a case...

About the error message you got while attempting to repack, the
exact same error message appears in two places, but the one that
is emitted is the one in sha1_file.c::unpack_delta_entry().  The
other one is in unpack-objects.c and is not run by repack.

This function is called after:

	- we find that we need to access an object;

	- we decided to use the .pack/.idx pair; when mmap'ing
          the .idx file, we validate that the pair is not
          corrupt by calling check_packed_git_idx().  This does
          the sha-1 checksum of both files;

	- we find the location of the deltified object in the
          .pack file by looking at the corresponding .idx;

	- we read from that location a handful bytes, find that
          it is deltified and learn its base object name.

So it is not likely that the .pack/.idx pair was corrupted after
it was written (i.e. not a bit rot).

Now, in unpack_delta_entry_function():

	- we find the location of its base object in the .pack
          file by looking at the .idx again; if this fails, we
          would die with a different error message "failed to
          find delta-pack base object";

	- we call unpack_entry_gently(); we would see the error
          message you saw only when this function returns NULL.

So unpack_entry_gently() while reading the base object returned
NULL.  Let's see how it can:

	- we read the data for the base object in the pack we
          identified earlier.  First we learn its type and size.

	- the base object could be also a deltified object, in
          which case it would recursively call unpack_delta_entry();
	  however, that function would never return NULL.  it
          either succeeds or die()s.  So the base must not have
          been OBJ_DELTA type.

        - the object type recorded there for the base object
          could have been something bogus, in which case we
          would return NULL.  But that would mean pack-object in
          1.4.2 generated a bogus pack on the mothership.

	- if the object type is not bogus, unpack_non_delta_entry()
          is called to extract the data for the base object.
          this decompresses the data stream, and if it does
          not inflate well it would return NULL.

So there are only a few ways you can get that error message.

	- pack-objects in 1.4.2 produced an invalid pack by
          recording:

          - bogus object type for the base object, or

          - incorrectly recording the offset of the base object in
            the pack file in .idx, or

	  - incorrectly recording the size of the base object in
            the pack file; 
 
 	  and checksumed the bogus resulting pack/idx pair as if
 	  nothing was wrong.

	- pack-objects in 1.4.2 produced a deflated stream that
          made unpack_non_delta_entry() unhappy.

Other changes between 1.4.0 and 1.4.2 that I do not think are
related are:

	- we slightly changed the way data is deflated with
          commit 12f6c30 to favour speed over compression, but
          this only affects loose objects and not packs.

	- we introduced a new file format for loose objects with
          commit 93821bd, but this needs to be explicitly
          enabled by .git/config option.  Even if the mothership
          1.4.2 had recorded loose objects in the new format,
          the process to create the pack by first expanding and
          then recompressing with the old-and-proven code, so
          this should not affect the resulting pack.  Even if
          such a loose object were copied to the note with 1.4.0
          together with the pack, object reading code always
          favours what's in the pack, so it should not even be
          touched.  Actually, the codepath that emits the error
          message does not read the base object from anywhere
          other than from the same pack.

	- we slightly changed the way data for the object to be
          deltified and the base object is read in pack-objects
          with commit 560b25a; I did not see anything obviously
          wrong with that change.

        - we slightly changed the way we pick the base object
          when making a delta with commits 8dbbd14 and 51d1e83;
          these should not change what happens after a pair is
          decided to be used as delta and its base.
