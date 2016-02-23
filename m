From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 2/2] submodule: Try harder to fetch needed sha1 by direct
 fetching sha1
Date: Mon, 22 Feb 2016 16:28:03 -0800
Message-ID: <CAGZ79ka-iAHvopwp==fTiuL13sJ_KzqotCNoOgQLJzvpNGH2HA@mail.gmail.com>
References: <1456180548-20996-1-git-send-email-sbeller@google.com>
	<1456180548-20996-3-git-send-email-sbeller@google.com>
	<xmqqzius2t31.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Dave Borowitz <dborowitz@google.com>,
	Jacob Keller <jacob.keller@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 23 01:28:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aY0pm-0003Qf-AT
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 01:28:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756051AbcBWA2G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2016 19:28:06 -0500
Received: from mail-ig0-f174.google.com ([209.85.213.174]:35443 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755903AbcBWA2E (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2016 19:28:04 -0500
Received: by mail-ig0-f174.google.com with SMTP id hb3so89019281igb.0
        for <git@vger.kernel.org>; Mon, 22 Feb 2016 16:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Gbb+yEjPXcvSj4M2WJys6ZxIH8BFnFcTDKkqtJN0SeQ=;
        b=iKipY/I8stOtzltlZ/lQ1NHGb8YTD7ob4wpWReTKJYuApWWkvOZj6hBtI1JEnBI7Ii
         TZEmq0djg/A+GMvci5SYsEwQ2CclMuk8sC6qFsvjQKFwsuhEjfZRzunPdLqCUJu4DjZT
         2Zvg0pb3phHtgBzgLj6yDWlhVX3B81J6BGqNfs2x7+2oXkQ11H7j/AD62lMYZouCjJNU
         JRgIRSxUqhgLjYtshpbFeezY/Chw3f3GX5JLTtzOJguD+SbB1AfO+kIZHc+3WfsaPnLd
         XW/ZNk2pgQenfGEOzA1PFBfEqSaYjV3JFD9Ia/sXUT+mMp5CHi1pc6RjQaqiWWENdLY/
         +Hzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=Gbb+yEjPXcvSj4M2WJys6ZxIH8BFnFcTDKkqtJN0SeQ=;
        b=OS70aKca4T8mwxcqu0NII34ZrDQtA1qWEpOD7Tvldy8arXhvr8XG7RD489lWAnIJYq
         PnTwlu+DhDCB7ulka2tcEB/Larw3Ar65rlpsWwHgpFUB402NGHnHAk9f/5xhqF80xxxw
         IZfEwWg9YBoU+NdQSOcgTU/kXpcPp/I5yTtNyaHV3Eao65AYO6BrKC4zdzIqLmCPxOpd
         cTEC48SfIdXktr5uLI6tuTyIxFiPNwfDslI8JWvlXSYH3qKU0VRl1DG3tYbQkncKG7OF
         fBIIECvml9MxUNVV5Tq+bBC+mE3bbmIjiqvA0Zd2NRtUGlxWL9VRO1R7RRRtxJNJyqbA
         Ed4g==
X-Gm-Message-State: AG10YOSY7XPHUS5bVampIBKjAMzNkkOA/iLtVAv4m0oXrlEyOStOKuMalQVG6+biXjkoteye8W7sqFhNlAaL3eql
X-Received: by 10.50.176.226 with SMTP id cl2mr10098137igc.85.1456187283330;
 Mon, 22 Feb 2016 16:28:03 -0800 (PST)
Received: by 10.107.4.210 with HTTP; Mon, 22 Feb 2016 16:28:03 -0800 (PST)
In-Reply-To: <xmqqzius2t31.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287003>

On Mon, Feb 22, 2016 at 4:01 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Stefan Beller <sbeller@google.com> writes:
>
> > We may want to discuss the error message. It is the same as in the case
> > before (git-fetch <no args>), this is good for translation, but may be bad
> > for the user as we may want to give extra information.
> > ("We fetched for you and it worked, however the sha1 was not included,
> > so we fetched again the server broke it, so we error out.  You used to
> > see error message: ....")
> >
> > Although this may be too much information?
>
> Now the "go to that submodule directory and see if $sha1 is
> reachable from any of the ref" check is written twice exactly the
> same way, it deserves to become a small helper function, I think.
>
> Perhaps something along this line?

This looks very readable.

Feel free to drop both my patches and just introduce this patch as yours!

>
>  git-submodule.sh | 29 ++++++++++++++++++++++++++---
>  1 file changed, 26 insertions(+), 3 deletions(-)
>
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 9bc5c5f..836348f 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -591,6 +591,24 @@ cmd_deinit()
>         done
>  }
>
> +is_tip_reachable () (
> +       clear_local_git_env
> +       cd "$1" &&
> +       rev=$(git rev-list -n 1 "$2" --not --all 2>/dev/null) &&
> +       test -z "$rev"

While we're talking about this code anyway, I wondered if we can make it
more cryptic again (just kidding!) and shorten it a bit by using the

    is_tip_reachable () (
        clear_local_git_env
        test -z $(git -C $1 rev-list -n 1 "$2" --not --all 2>/dev/null)
    )

> +)
> +
> +fetch_in_submodule () (
> +       clear_local_git_env
> +       cd "$1" &&
> +       case "$2" in
> +       '')
> +               git fetch ;;
> +       *)
> +               git fetch $(get_default_remote) "$2" ;;
> +       esac
> +)
> +
>  #
>  # Update each submodule path to correct revision, using clone and checkout as needed
>  #
> @@ -745,9 +763,14 @@ Maybe you want to use 'update --init'?")"
>                         then
>                                 # Run fetch only if $sha1 isn't present or it
>                                 # is not reachable from a ref.
> -                               (clear_local_git_env; cd "$sm_path" &&
> -                                       ( (rev=$(git rev-list -n 1 $sha1 --not --all 2>/dev/null) &&
> -                                        test -z "$rev") || git-fetch)) ||
> +                               is_tip_reachable "$sm_path" "$sha1" ||
> +                               fetch_in_submodule "$sm_path" ||
> +                               die "$(eval_gettext "Unable to fetch in submodule path '\$displaypath'")"
> +
> +                               # Now we tried the usual fetch, but $sha1 may
> +                               # not be reachable from any of the refs
> +                               is_tip_reachable "$sm_path" "$sha1" ||
> +                               fetch_in_submodule "$sm_path" "$sha1" ||

For another split second I wondered about the return code of is_tip_reachable,
if the result is actually negated, but reading the chaining here, makes sense.

Thanks,
Stefan

>                                 die "$(eval_gettext "Unable to fetch in submodule path '\$displaypath'")"
>                         fi
>
