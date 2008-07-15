From: "Geoffrey Irving" <irving@naml.us>
Subject: Re: What's cooking in git.git (topics)
Date: Mon, 14 Jul 2008 20:38:00 -0700
Message-ID: <7f9d599f0807142038w62ccb69fv42d6dcf3dd4f2afd@mail.gmail.com>
References: <7vlk4snpj3.fsf@gitster.siamese.dyndns.org>
	 <7vk5ggipuw.fsf@gitster.siamese.dyndns.org>
	 <7vej6l3lp7.fsf@gitster.siamese.dyndns.org>
	 <7vod5kd3im.fsf@gitster.siamese.dyndns.org>
	 <7v3amv1e8n.fsf@gitster.siamese.dyndns.org>
	 <7vprpwhp7t.fsf@gitster.siamese.dyndns.org>
	 <7vlk0ffhw3.fsf@gitster.siamese.dyndns.org>
	 <7vtzf1w0rj.fsf@gitster.siamese.dyndns.org>
	 <7vabgqsc37.fsf@gitster.siamese.dyndns.org>
	 <7vtzetjbif.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 15 05:39:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIbNX-00058j-P1
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 05:39:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753968AbYGODiF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 23:38:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753716AbYGODiE
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 23:38:04 -0400
Received: from rv-out-0506.google.com ([209.85.198.234]:63488 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753804AbYGODiB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 23:38:01 -0400
Received: by rv-out-0506.google.com with SMTP id k40so5796435rvb.1
        for <git@vger.kernel.org>; Mon, 14 Jul 2008 20:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=Xu1Vx8uppjqbC2Z//1yZ3xao3JjFL3xuqmugHgyPzRI=;
        b=GUsBlrDS9Weqz5++FNCf4M8plAgj0H14YXpKm2D8ms29SeS1yzM9Y8PJR0kW7oJ7FR
         wvoixrXKDCXSjcvoloO2qw/IbP5k3ywBIvV+9kWP+mlgnmkoIJqXUwRXP7pkZUtiGnOP
         xeBaBrH3TfAO05go4CF4NoUcqYx83sqopqs1I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=qaUtfqZcKm2QRu7s0tJJt2pi8GxJ/MaMKxZXdx+TbARVT4vVegGCXXEwRYUiPV1geb
         Bvw/DcesCuIo28Sx0RrabDgiYKwX4YWUltHzEOPe1zH6BnR/YVJyxkbMNqzqZWcuSUkE
         85U3dX2i7IS39Ei1WrsBctwjsYwtedF4bSgUw=
Received: by 10.141.172.6 with SMTP id z6mr7067435rvo.112.1216093081162;
        Mon, 14 Jul 2008 20:38:01 -0700 (PDT)
Received: by 10.141.202.6 with HTTP; Mon, 14 Jul 2008 20:38:00 -0700 (PDT)
In-Reply-To: <7vtzetjbif.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
X-Google-Sender-Auth: ff43b300473c86bb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88514>

On Sun, Jul 13, 2008 at 10:11 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Here are the topics that have been cooking.  Commits prefixed
> with '-' are only in 'pu' while commits prefixed with '+' are
> in 'next'.
>
> <snip>
>
> * gi/cherry-cache (Sat Jul 12 20:14:51 2008 -0700) 1 commit
>  - cherry: cache patch-ids to avoid repeating work
>
> This does not seem to pass tests even on its own.

The problem (beyond the basic problem of me not having tried running
the tests) is that the current caching code isn't taking into account
the changing values of diff_options.  t6007 computes a patch-id for a
commit with one value of options.paths, and then tries to compute a
_different_ patch-id for the same commit using a different value of
options.paths.

Here are a few different ways of fixing this:

1. Modify commit_patch_id in patch-ids.c to compute a sha1 of the
diff_options structure and xor it with the commit sha1 to get a truly
unique hash of the input.  This means the optimization can be safely
applied for all patch-id computations regardless of the diff_options.
I can add a diff_options_sha1 function in diff.[ch] to compute the
checksum.

2. Restrict commit_patch_id in patch-ids.c to apply the optimization
only if options.nr_paths is zero, and perhaps a few other conditions.
This is rather fragile, since it would mean that the cache would break
if someone decided to change the default diff options.

3. Add a flag in struct patch_ids defaulting to false which turns the
caching on or off, and manually set the flag to true in cmd_cherry.

I'd lean towards (1), but wanted to check before writing the code to
make sure that it's reasonable to treat diff_options as stable enough
that computing a sha1 hash of it makes sense.  According to "git help
patch-id", it is only "reasonable stable", which is sufficient as long
as we're confident that whenever the diff format changes, the
diff_options_sha1 function will be updated to reflect that change.

As an aside: is it correct that as long as the change is in pu, I
should be submitting complete (nonincremental) patches whenever I fix
bugs?

Thanks,
Geoffrey
