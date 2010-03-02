From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [PATCH 4/5] grep: Colorize filename, line number, and separator
Date: Mon, 01 Mar 2010 22:43:23 -0800 (PST)
Message-ID: <4b8cb38b.870fcc0a.7ebc.1a83@mx.google.com>
References: <1267246670-19118-1-git-send-email-lodatom@gmail.com> 
	<1267246670-19118-5-git-send-email-lodatom@gmail.com> <4B890572.5040604@lsrfire.ath.cx> 
	<ca433831002281214q14e6e62bj54cf7227cd32873b@mail.gmail.com> 
	<b4087cc51002281426m126a0c07l9f4a38088d0146b1@mail.gmail.com>
	<ca433831003011749h43293f80kd4ec18bd796dea7c@mail.gmail.com>
Cc: git@vger.kernel.org
To: Mark Lodato <lodatom@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 02 07:43:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmLpM-0006CR-T9
	for gcvg-git-2@lo.gmane.org; Tue, 02 Mar 2010 07:43:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752932Ab0CBGn0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Mar 2010 01:43:26 -0500
Received: from mail-bw0-f209.google.com ([209.85.218.209]:58608 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752410Ab0CBGn0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Mar 2010 01:43:26 -0500
Received: by bwz1 with SMTP id 1so841848bwz.21
        for <git@vger.kernel.org>; Mon, 01 Mar 2010 22:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:cc
         :subject:in-reply-to:references;
        bh=zD6GvEu6yvEMBtos+WNlyvSQeLtiy8smwS1hcWY3V5Y=;
        b=owuVArjgGpT3fBmjjHhzUyL7Evf0raylUDpv1incWYOsg//197uKJpUvxtk3A9FVi3
         nLnOtp0pje94n6Bf4z48hQG10TCQXbxFykCNPVOdRjUc4sm11geTmAuz3MnqS7tvZ0Yc
         VVrJ6wDA/HovzEYkkRODRb16CDoiNkF3bcyik=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:cc:subject:in-reply-to:references;
        b=BgNno0MxlNbtM5tKOWQqOhnO3QhRo8AR5m1q/EioZD7wVxCzlhcergS7fx2VM7odYg
         eOa5ftxwq6Tfi0HV143U+i8Va49rkpfxZgiLE2x002y+1/xyDxY22iTu9S0br0RX3PEr
         oZNq/QGi3ibZuktyMYZuq1F+turPrTOxrwtnI=
Received: by 10.204.133.91 with SMTP id e27mr4058944bkt.19.1267512204183;
        Mon, 01 Mar 2010 22:43:24 -0800 (PST)
Received: from gmail.com (93-34-240-158.ip52.fastwebnet.it [93.34.240.158])
        by mx.google.com with ESMTPS id k7sm2689910bka.10.2010.03.01.22.43.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Mar 2010 22:43:23 -0800 (PST)
In-Reply-To: <ca433831003011749h43293f80kd4ec18bd796dea7c@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141376>

> Something like [1]?

Ah! Good!

>> with `auto' as the default for a plain --color.
>
> By the way, the default should be 'always', not
> 'auto', to be consistent with GNU tools, and to be backwards
> compatible with the old --color behavior.

Well, I've got:

    GNU grep 2.5.4

and the default for a plain `--color' seems to be `auto', whereby
colorization is turned on when stdout is attached to a tty capable
of color, but turned off otherwise:

    echo t > t

    /bin/grep t t --color              # t is colored red
    /bin/grep t t --color        | cat # t is not colored
    /bin/grep t t --color=always | cat # t is colored

Let's see how the GNU grep source sets up colorization:

    case COLOR_OPTION:
        if(optarg) {
          if(!strcasecmp(optarg, "always") || !strcasecmp(optarg, "yes") ||
             !strcasecmp(optarg, "force"))
            color_option = 1;
          else if(!strcasecmp(optarg, "never") || !strcasecmp(optarg, "no") ||
                  !strcasecmp(optarg, "none"))
            color_option = 0;
          else if(!strcasecmp(optarg, "auto") || !strcasecmp(optarg, "tty") ||
                  !strcasecmp(optarg, "if-tty"))
            color_option = 2;
          else
            show_help = 1;
        } else
          color_option = 2;     /* <--------------- default           */
        /* the rest of this case statement (see below) */

Firstly, note that GNU understands a wide set of option arguments:

    1: always , yes , force
    0: never  , no  , none
    2: auto   , tty , if-tty

Secondly, note that the default mode is that which is selected by
auto/tty/if-tty:

    color_option = 2;

However, there's a little code left that specially processes this
'auto' mode to transform it into either 'always' or 'never':

        if(color_option == 2) {
          if(isatty(STDOUT_FILENO) && getenv("TERM") &&
             strcmp(getenv("TERM"), "dumb"))
                  color_option = 1;
          else
            color_option = 0;
        }
        break;

Thus, if stdout is attached to a tty that understands color, then
colorization is turned on; otherwise, colorization is turned off.

In my opinion, Git grep should follow GNU grep's conventions, not
only to be consistent, but also because they are better.

>> Of course, I bet you find colorizing the filenames a nuisance because
>> you don't care to pipe the relevant escape sequences to other
>> commands.
>
> I'm not quite sure what you mean here, but my reason has nothing to do
> with piping.  If the output is entirely in a single color, I would
> prefer that color to be my terminal's default.  The color adds no
> value.

Unfortunately, Git grep interprets a plain `--color' the same way
that GNU grep interprets `--color=always', so that the color
escape sequences get piped to everything.

    $ cd $clean_repo_for_git_source
    $ grep ':-)' -R . --exclude-dir=.git --color | cut -c 3- > smilies-gnu
    $ git grep --color ':-)' > smilies-git

    $ ls -l smilies*     # Note the size difference
    -rw-r--r-- 1 mfwitten mfwitten 813 Mar  1 05:43 smilies-git
    -rw-r--r-- 1 mfwitten mfwitten 717 Mar  1 05:43 smilies-gnu
    
    $ cat -t smilies-gnu
    Documentation/glossary-content.txt:^IThe list you get with "ls" :-)
    Documentation/technical/pack-heuristics.txt:        have to build up a certain level of gumption first :-)
    Documentation/technical/pack-heuristics.txt:       even realize how much I wasn't realizing :-)
    Documentation/technical/pack-heuristics.txt:        the cases where you might have to wander, don't do that :-)
    Documentation/technical/pack-heuristics.txt:        I'm getting lost in all these orders, let me re-read :-)
    Documentation/technical/pack-heuristics.txt:        can just read what you said there :-)
    Documentation/technical/pack-heuristics.txt:    <njs`> :-)
    Documentation/technical/pack-heuristics.txt:        details on git packs :-)
    
    $ cat -t smilies-git
    Documentation/glossary-content.txt:^IThe list you get with "ls" ^[[31m^[[1m:-)^[[m
    Documentation/technical/pack-heuristics.txt:        have to build up a certain level of gumption first ^[[31m^[[1m:-)^[[m
    Documentation/technical/pack-heuristics.txt:       even realize how much I wasn't realizing ^[[31m^[[1m:-)^[[m
    Documentation/technical/pack-heuristics.txt:        the cases where you might have to wander, don't do that ^[[31m^[[1m:-)^[[m
    Documentation/technical/pack-heuristics.txt:        I'm getting lost in all these orders, let me re-read ^[[31m^[[1m:-)^[[m
    Documentation/technical/pack-heuristics.txt:        can just read what you said there ^[[31m^[[1m:-)^[[m
    Documentation/technical/pack-heuristics.txt:    <njs`> ^[[31m^[[1m:-)^[[m
    Documentation/technical/pack-heuristics.txt:        details on git packs ^[[31m^[[1m:-)^[[m

If you just run a plain `cat smilies-git', your terminal should
still render the colorization, as the escape sequences are
preserved. This is generally a nuisance because normally it
is desirable to lose that information when piping it to places
other than the screen.

> If the output is entirely in a single color, I would prefer that
> color to be my terminal's default. The color adds no value.

I would prefer whatever color to which I've become accustomed; the
color is also a quick indication of what you're viewing. I usually
keep altering the search pattern until I get the right set of
matches and THEN issue `--name-only' to get just the paths; when
I do that, I expect the output to change just by cutting out the
stuff to the right of the paths, but your suggestion would ALSO
cause the color to change. In my opinion, that's jarring.

Moreover, with a plain `--color' being interpreted as `--color=auto',
I would also have the benefit of piping the output anywhere else and
never having to bother with `--no-color' or `--color=never' or just
removing `--color'.

In short, I think the GNU strategy is the most intuitive and
streamlined approach.

>> As a compromise (and perhaps as an improvement), perhaps
>> only the basename of the filename should be colorized when
>> --name-only is used; that way, colorization is still being used
>> to differentiate different data, and the rest of the path is
>> usually not that interesting anyway. However, for consistency,
>> I would still think it wise to colorize the dirname portion
>> with `color.grep.filename', but color the basename portion with
>> `color.grep.match' (as though the basename portion is the text
>> being matched).
>
> Personally, I am not a fan of this, but if it is implemented, it
> should be an option, and should be turned off by default. Instead
> of highlighting the name, it may be better to simply highlight the
> slashes so the reader can more easily parse the path. But still, I
> don't think this is worth the trouble.

The basenames of paths are almost always the most important piece of
data. Still, my suggestion is to leave the whole path colorized as
usual when colorization is active.

Sincerely,
Michael Witten
