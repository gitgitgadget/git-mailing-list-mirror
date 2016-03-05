From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Resumable clone
Date: Sat, 05 Mar 2016 10:31:50 -0800
Message-ID: <xmqqoaasvkrt.fsf@gitster.mtv.corp.google.com>
References: <CANtyZjSJf5_xbsBC5tUaazFT3uiEgJnx2_kHLwYwKcn50Jy_qg@mail.gmail.com>
	<CACsJy8CESL6vH22mGSLRE1OKTEbGz2Vqmsv5bY3mn_E+03wADw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Kevin Wern <kevin.m.wern@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 05 19:31:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1acGze-0008Fj-H6
	for gcvg-git-2@plane.gmane.org; Sat, 05 Mar 2016 19:31:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750915AbcCESbz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Mar 2016 13:31:55 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62058 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750889AbcCESbx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Mar 2016 13:31:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E723B48FA9;
	Sat,  5 Mar 2016 13:31:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tmCxK2w5T3Q+PuNlETrYzRU/qQI=; b=gKYc5w
	ASUcGHTtSZ/wnR20P3NZYClDpN7H5APu1WiP9mVrnoBjZT1jhG0TZi6n/fZeOy5n
	pfea7YZ9CGipoDbUCBQdgaUi8rzhQA1xlhk/Wy77Sa4HU2Na3e5PXAqf5cjOdAm/
	Y9H8bIA49KUIuBeLy4cYMQFGJCLpLuVxitBIk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FIxlWKHR4C5oXit7n8vxya6ENFEACWEf
	1ArAuxvvCEuSvsjTEg4MZSmmZrscM29hD1AlTR1pp/EGsoN32Py8apXZDaBwj6js
	WkcgrDlerR91/8gzLjnWbUa65ZVh9Vq562FT7xD/uaUp69buHJhzlaZl9PoAj+DQ
	I0aDfOvE5WM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DE2FB48FA8;
	Sat,  5 Mar 2016 13:31:51 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 41E2248FA7;
	Sat,  5 Mar 2016 13:31:51 -0500 (EST)
In-Reply-To: <CACsJy8CESL6vH22mGSLRE1OKTEbGz2Vqmsv5bY3mn_E+03wADw@mail.gmail.com>
	(Duy Nguyen's message of "Sat, 5 Mar 2016 16:40:15 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 87393E36-E300-11E5-BFB7-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288317>

Duy Nguyen <pclouds@gmail.com> writes:

> Resumable clone is happening. See [1] for the basic idea, [2] and [3]
> for some preparation work. I'm sure you can help. Once you've gone
> through at least [1], I think you can pick something (e.g. finalizing
> the protocol, update the server side, or git-clone....)
>
> [1] http://thread.gmane.org/gmane.comp.version-control.git/285921
> [2] http://thread.gmane.org/gmane.comp.version-control.git/288080/focus=288150
> [3] http://thread.gmane.org/gmane.comp.version-control.git/288205/focus=288222

I think your response needs to be refined with a bit higher level
overview, though.  Here are some thoughts to summarize the
discussion and to extend it.

I think the right way to think about this is that we are adding a
capability for the server to instruct the clients: I prefer not to
serve a full clone to you in the usual route if I can avoid it.  You
can help me by going to an alternate resource and populate your
history first and then coming back to me for an additional fetch to
complete the history if you want to.  Doing so would also help you
because that alternate resource can be a static file (or two) that
you can download over a resumable transport (like static files
served over HTTPS).

That alternate resource could be just an old-style bundle file
(e.g. kernel.org prepares such a bundle file for Linus's kernel
repository and makes it available on CDN on a weekly basis;
cf. https://kernel.org/cloning-linux-from-a-bundle.html).

One downside of using the old-style bundle is that it would weigh
about the same as the fully repacked bare repository itself, and
would require the same amount of CPU and disk resource to generate
as it would take to repack.  The "split bundle" discussion with Jeff
King is about one possible way to reduce that waste.  The old-style
bundle is just a header file tucked in front of a packfile, and by
introducing a new bundle format that stores only the header part in
a file that points at an existing packfile, we can reduce the waste.
A few patches from me on "bundle" and "index-pack --clone-bundle"
sent for the past several days are about that approach.  During a
repack the server operators periodically make, we can also create
the header part of the new bundle format that points at the full
packfile that is produced in order to serve the regular "fetch/push"
traffic.

My response to [3] in the thread further points at a new direction.
The "alternate resource" does not have to be a bundle, but can be
just a full packfile (i.e. pack-$name.pack).  After a full repack,
the server operators can make the packfile available to clients over
a resumable transport.  The client has to run "index-pack" on the
downloaded pack-$name.pack to generate the "pack-$name.idx" file in
order to make it usable, so the logic to implement "--clone-bundle"
introduced initially for the "split bundle" approach can be
repurposed to be run on the client.  With a single pack-$name.pack
file, the client can

 - Place it in .git/objects/pack in an empty repository;

 - Generate corresponding pack-$name.idx file next to it;

 - Learn where the tips of histories (i.e. "all objects that are
   reachable from these objects are already available in this
   repository") are.

And the above is sufficient to do the "coming back to me for an
additional fetch" efficiently.  The tips of histories can be sent as
extra "have" records during such a fetch with a minor update to the
"fetch" code.

So what remains?  Here is a rough and still slushy outline:

 - A new method, prime_clone(), in "struct transport" for "git
   clone" client to first call to learn the location of the
   "alternate resource" from the server.

   - The server side endpoint does not have to be, and I think it
     should not be, implemented as an extension to the current
     upload-pack protocol.  It is perfectly fine to add a new "git
     prime-clone" program next to existing "git upload-pack" and
     "git receive-pack" programs and drive it through the
     git-daemon, curl remote helper, and direct execution over ssh.

   - The format of the returned "answer" needs to be designed.  It
     must be able to express:

     - the location of the resource, i.e. a URL;

     - the type of resource, if we want this to be extensible.  I
       think we should initially limit it to "a single full history
       .pack", so from that point of view this may not be absolutely
       necessary, but we already know that we may want to say "go
       there and you will find an old-style bundle file" to support
       the kernel.org CDN, and we may also want to support Jeff's
       "split bundle" or Shawn's ".info" file.  A resource poor
       (read: personal) machine that hosts a personal of a popular
       project might want to name a "git clone" URL for that popular
       project it forked from (e.g. "Clone Linus's repository from
       kernel.org and then come back here for incremental fetch").

 - A new method, download_primer(), in "struct transport" to
   download the "alternate resource" learned from an earlier call to
   the prime_clone() method.

   - I expect that a typical answer to the "prime-clone" (see above)
     request would be an HTTP(s) URL for a single pack file, or the
     header file of a "split bundle" pair.  The curl remote helper
     would implement this as an equivalent of "wget -c" of these
     files.

   - The answer to "prime-clone" request could name "git://" URL,
     and it is OK to design a new server-side endpoint to respond to
     download_primer() method, aka "a minimal resumable download
     service via git-daemon" Duy mentioned in [1].

 - To support the case where the server responds with "a single full
   .pack file" to prime_clone():

   - "index-pack" needs to be extended to compute the tips of the
     history contained within (the logic is already done, but if the
     "split bundle" output is not the best one to use, we may need
     to update the output format);

   - The way the "tips of the history" is told to "fetch-pack" that
     does the final incremental fetch to the original site needs to
     be designed.  It could be a "throw-away temporary sub-hierarchy
     somewhere in refs/" I alluded to in [2], but there may be
     better designs (e.g. naming a split bundle as "--reference" to
     a fresh invocation of the "git clone" command).

 - Update "git clone" (builtin/clone.c).

   - Refactor it to make it easier to wedge in the new code (below),
     if necessary.

   - Teach it a new "--resume" option.

     - When the command is run with this option, no other option
       must be given.

     - If the existing (half cloned) repository is not marked as
       resumable, the command must fail.

     - The first few steps below are skipped (i.e. we do not create
       worktree and gitdir, we do not do init_db(), we do not write
       refspec configuration).

   - Let the original code run up to the point where it creates
     worktree and gitdir, does init_db(), and writes the refspec
     configuration.

   - If some options are given that makes it less efficient to do
     the "prime from an alternate resource and then fetch", do not
     do anything special and let the original code run to the end
     (i.e. no resuming).  This may include cases where "--reference"
     is given, indicating that the bulk of objects are already
     available locally.  The details of this determination need to
     be worked out.

   - If we are doing the "prime from an alternate and then fetch",
     before the current code calls transport_fetch_refs(), call a
     new transport API function, transport_prime_clone(), to learn
     if the server wants us to prime from an "alternate resource".
     If not, let the original code run to the end.

   - If we are still doing the "prime from an alternate and then
     fetch", mark the repository as resumable, and call
     transport_download_primer(), a new transport API function.
     This will implement the "retry until successfully download the
     whole thing" and "continue from where its earlier incarnation
     was killed".

   - Once transport_download_primer() finishes downloading the
     "alternate resource", prime the object store and record the
     tips of the history.

   - Perform an incremental "fetch" against the original repository.

   - Finalize the clone, e.g. point our HEAD to a correct branch,
     start our 'master' (or whatever primary branch name is) branch
     at a correct place in the history and check the files out to
     the working tree.

[1] http://thread.gmane.org/gmane.comp.version-control.git/288080/focus=288161
[2] http://thread.gmane.org/gmane.comp.version-control.git/288205/focus=288222
