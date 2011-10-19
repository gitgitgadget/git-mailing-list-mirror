From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 2/2] Restrict ref-like names immediately below $GIT_DIR
Date: Wed, 19 Oct 2011 22:31:53 +0200
Message-ID: <4E9F33B9.4040803@alum.mit.edu>
References: <1316121043-29367-1-git-send-email-mhagger@alum.mit.edu> <1316121043-29367-20-git-send-email-mhagger@alum.mit.edu> <20111011161652.GA15629@sigill.intra.peff.net> <7vr52jfm8i.fsf@alter.siamese.dyndns.org> <7vmxd7flkw.fsf@alter.siamese.dyndns.org> <7v39ezffq5.fsf_-_@alter.siamese.dyndns.org> <20111011230749.GA29785@sigill.intra.peff.net> <7vehyjcckp.fsf@alter.siamese.dyndns.org> <20111012021128.GA32149@sigill.intra.peff.net> <7v39eyddoc.fsf@alter.siamese.dyndns.org> <20111012045004.GA22413@sigill.intra.peff.net> <7vvcru9k22.fsf_-_@alter.siamese.dyndns.org> <4E95D60B.5030904@alum.mit.edu> <7vr52i9j8g.fsf@alter.siamese.dyndns.org> <4E9609E3.1000300@alum.mit.edu> <7v39epft32.fsf@alter.siamese.dyndns.org> <7vaa8wdbld.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, cmn@elego.de,
	A Large Angry SCM <gitzilla@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 19 22:32:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGcoI-0001lM-OG
	for gcvg-git-2@lo.gmane.org; Wed, 19 Oct 2011 22:32:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753759Ab1JSUcS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Oct 2011 16:32:18 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:36028 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753607Ab1JSUcR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2011 16:32:17 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p9JKVsVn009101
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 19 Oct 2011 22:31:54 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.23) Gecko/20110921 Lightning/1.0b2 Thunderbird/3.1.15
In-Reply-To: <7vaa8wdbld.fsf@alter.siamese.dyndns.org>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183946>

On 10/19/2011 09:29 PM, Junio C Hamano wrote:
> In general, the "Hey that file that appears in our dwimmed ref namespace
> does not store correct [0-9a-f]{40} contents" warning message is a good
> thing to have. When we try the dwimmery and disambiguation, we however
> look at the potential refs and warn disambiguity only when two or more
> such files have good contents. E.g. if I do this:
> 
>     $ git rev-parse HEAD >.git/refs/heads/frotz
>     $ echo hello >.git/refs/tags/frotz
>     $ git show frotz
> 
> we have never paid attention to the broken tag and showed the 'frotz'
> branch without complaining. Once tags/frotz gets a real object name,
> however, we start giving ambiguity warnings.
> 
> Perhaps that is what we should be fixing instead.

This all sounds very sane.  dwim_ref() currently casts about wildly
looking for possible references, so it makes sense that it be selective
about what warnings it emits.  I also agree with the principle that this
warning is better emitted from higher-level code.

> Perhaps resolve_ref() should return in its *flag parameter that "a file
> exists there but incorrectly formatted", and dwim_ref() should notice and
> use that information to warn about ambiguity and also illformed-ness.

ISTM that such warnings should also be emitted when (for example) the
following commands encounter corrupt references: "git fsck", "git
pack-refs", "git gc", and "git push".  (Maybe these commands already
emit warnings; I haven't checked.)  These commands are not run so
frequently (so that the warnings would not be so annoying).  They are
also presumably not so promiscuous about where they look for refs and
therefore won't generate so many false alarms.

But it will be easy to add warnings to these commands using the
REF_ISBROKEN flag that you made public.

> A patch is attached at the end of this message to minimally fix what is in
> 'master' (without the jc/check-ref-format-fixup topic).  [...]

I would have preferred this change being applied on top of your first
patch in jc/check-ref-format-fixup, because moving these functions to
refs.c makes sense.  (Not to mention that my "REFNAME_FULL" patch series
is built on top of jc/check-ref-format-fixup.)

>  refs.c      |   22 +++++++++++-----------
>  refs.h      |    5 +++--
>  sha1_name.c |    5 ++++-
>  3 files changed, 18 insertions(+), 14 deletions(-)
> 
> diff --git a/refs.c b/refs.c
> index cab4394..0f58e46 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -329,12 +328,12 @@ static void get_ref_dir(const char *submodule, const char *base,
>  				flag = 0;
>  				if (resolve_gitlink_ref(submodule, ref, sha1) < 0) {
>  					hashclr(sha1);
> -					flag |= REF_BROKEN;
> +					flag |= REF_ISBROKEN;
>  				}

The renaming of this constant could have been done in a separate patch
to reduce noise like this in the main patch.

Otherwise the patch looks fine to me.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
