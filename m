From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: [PATCH v2] Prefer sysconf(_SC_OPEN_MAX) over getrlimit(RLIMIT_NOFILE,...)
Date: Fri, 24 Aug 2012 20:36:21 +0200
Message-ID: <004801cd8227$5bce8910$136b9b30$@schmitz-digital.de>
References: <002f01cd81de$28f43bf0$7adcb3d0$@schmitz-digital.de> <7v393c1br5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "'Junio C Hamano'" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 24 20:36:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4ykU-0001s0-Tq
	for gcvg-git-2@plane.gmane.org; Fri, 24 Aug 2012 20:36:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760012Ab2HXSgo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Aug 2012 14:36:44 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:51472 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751687Ab2HXSgh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Aug 2012 14:36:37 -0400
Received: from DualCore (dsdf-4db5d8d2.pool.mediaWays.net [77.181.216.210])
	by mrelayeu.kundenserver.de (node=mrbap1) with ESMTP (Nemesis)
	id 0MUCR8-1TDCDl1hRq-00QXit; Fri, 24 Aug 2012 20:36:31 +0200
In-Reply-To: <7v393c1br5.fsf@alter.siamese.dyndns.org>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQJQxEZLob1wIOvdtgEy8gomHPj50gFgkEXZlle+SHA=
Content-Language: de
X-Provags-ID: V02:K0:06cjx4TbH3bRwCCkg3EWOMkLT16LP4Uftw2Es0saYIC
 B1zct3kKAmtMsi/+VT8g6OMXfZiQ7UYLjZXPWMH4WnE/CBNf9I
 sZk9rpC9ar94GNsUMsb5sXv5v9kwyr3lHWukJdGD3sBq8xn62N
 n6dC6pQXBPdKGOSwch8U2GMLxqQWNJtM1XniaCIoANGFe3D3gC
 AOZtRr0SsN+6Np6fm3/RKB49tfn2eaT3lswHXIrAjvW0glZhnO
 Hu3RRin6n8z9Hca3jMaEetgRwIsoTHWWhSqK8F0uSbTaGls4FD
 2OBBPw9SuthV5T+tLaaBCTX57yYnrLioTOf+AnfGFwpP+wdM/D
 AdQdCud+KSCX9XIIFcWWqk69HH6TjN23NdY9Oah16vwzDSUvdt
 ndn2Ax9BlVANg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204226>

> From: Junio C Hamano [mailto:gitster@pobox.com]
> Sent: Friday, August 24, 2012 6:44 PM
> To: Joachim Schmitz
> Cc: git@vger.kernel.org
> Subject: Re: [PATCH v2] Prefer sysconf(_SC_OPEN_MAX) over getrlimit(RLIMIT_NOFILE,...)
> 
> "Joachim Schmitz" <jojo@schmitz-digital.de> writes:
> 
> > Signed-off-by: Joachim Schmitz <jojo@schmitz-digital.de>
> > ---
> > As discussed now as a small helper function rather than #ifdef/#endif in the primary flow of the code.
> > And hopefully without having screwed up whitespace and line breaks
> 
> The formatting looks fine.
> 
> Perhaps I am being overly paranoid, but I would prefer not to change
> things for people who have been using getrlimit().  For them, if
> they also have sysconf(_SC_OPEN_MAX), your code _ought to_ work, but
> if it does not work for whatever reason (perhaps some platforms
> claim to have both, but getrlimit() works and sysconf(_SC_OPEN_MAX)
> is broken), it will given them an unnecessary regression.

Sounds reasonable, so reasonable that I wonder why I didn't have that idea ;-)

> So how about doing it this way instead?
> 
> -- >8 --
> Subject: sha1_file.c: introduce get_max_fd_limit() helper
> 
> Not all platforms have getrlimit(), but there are other ways to see
> the maximum number of files that a process can have open.  If
> getrlimit() is unavailable, fall back to sysconf(_SC_OPEN_MAX) if
> available, and use OPEN_MAX from <limits.h>.
> 
> Signed-off-by: Joachim Schmitz <jojo@schmitz-digital.de>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  sha1_file.c | 26 +++++++++++++++++++-------
>  1 file changed, 19 insertions(+), 7 deletions(-)
> 
> diff --git c/sha1_file.c w/sha1_file.c
> index af5cfbd..9152974 100644
> --- c/sha1_file.c
> +++ w/sha1_file.c
> @@ -731,6 +731,24 @@ void free_pack_by_name(const char *pack_name)
>  	}
>  }
> 
> +static unsigned int get_max_fd_limit(void)
> +{
> +#ifdef RLIMIT_NOFILE
> +	struct rlimit lim;
> +
> +	if (getrlimit(RLIMIT_NOFILE, &lim))
> +		die_errno("cannot get RLIMIT_NOFILE");
> +
> +	return lim.rlim_cur;
> +#elif defined(_SC_OPEN_MAX)
> +	return sysconf(_SC_OPEN_MAX);
> +#elif defined(OPEN_MAX)
> +	return OPEN_MAX;
> +#else
> +	return 1; /* see the caller ;-) */
> +#endif
> +}
> +
>  /*
>   * Do not call this directly as this leaks p->pack_fd on error return;
>   * call open_packed_git() instead.
> @@ -747,13 +765,7 @@ static int open_packed_git_1(struct packed_git *p)
>  		return error("packfile %s index unavailable", p->pack_name);
> 
>  	if (!pack_max_fds) {
> -		struct rlimit lim;
> -		unsigned int max_fds;
> -
> -		if (getrlimit(RLIMIT_NOFILE, &lim))
> -			die_errno("cannot get RLIMIT_NOFILE");
> -
> -		max_fds = lim.rlim_cur;
> +		unsigned int max_fds = get_max_fd_limit();
> 
>  		/* Save 3 for stdin/stdout/stderr, 22 for work */
>  		if (25 < max_fds)

Looks good to me. 
Stupid newbie question: how would I revert my commit to my clone, to then add (and test) this one?

Bye, Jojo
