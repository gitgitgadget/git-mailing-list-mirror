Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.5 required=3.0 tests=BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65EFB1F404
	for <e@80x24.org>; Wed, 28 Feb 2018 21:47:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935061AbeB1VrA (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 16:47:00 -0500
Received: from tartarus.angband.pl ([89.206.35.136]:55258 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935042AbeB1Vq7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 16:46:59 -0500
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.89)
        (envelope-from <kilobyte@angband.pl>)
        id 1er9Ys-0002wL-50; Wed, 28 Feb 2018 22:46:54 +0100
Date:   Wed, 28 Feb 2018 22:46:54 +0100
From:   Adam Borowski <kilobyte@angband.pl>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Miklos Vajna <vmiklos@suse.cz>
Subject: Re: [PATCH] hooks/pre-auto-gc-battery: allow gc to run on non-laptops
Message-ID: <20180228214654.t4rcqmcb37q3grdh@angband.pl>
References: <20180228044807.1000-1-kilobyte@angband.pl>
 <xmqqpo4pkmiy.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqpo4pkmiy.fsf@gitster-ct.c.googlers.com>
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 28, 2018 at 10:16:21AM -0800, Junio C Hamano wrote:
> Adam Borowski <kilobyte@angband.pl> writes:
> 
> > Desktops and servers tend to have no power sensor, thus on_ac_power returns
> > 255 ("unknown").
> >
> > If that tool returns "unknown", there's no point in querying other sources
> > as it already queried them, and is smarter than us (can handle multiple
> > adapters).
> 
> The explanation talks about the exit status 255 being special and
> serves to signal "there is no point continuing, and it is OK to
> assume we are not on batttery", while the code says that anything
> but exit status 1 can be treated as such.  Which is correct?

As the man page says:

# EXIT STATUS
#       0 (true)  System is on mains power
#       1 (false) System is not on mains power
#       255 (false)    Power status could not be determined

0 usually means a laptop on AC power, 255 is for a typical desktop.
The current code can't return 2 or any other unexpected value, but if it
ever does, an unknown error should probably be treated same as 255 unknown.
Thus, gc should be avoided only if the return code is 1.

As for the second paragraph, I meant that on_ac_power already queried all
sources this hook knows about (other than /usr/bin/pmset which is OSX
only[1]), thus if the answer is "unknown", continuing to query is redundant.

If that's unclear, do you have some other wording in mind?

Also, it's good to trust on_ac_power, as it'll get updated whenever new
quirks of power management get known: I heard allegations that some boards
say "USB" instead of "Mains", which should count the same for our
purposes[2].  It's not reasonable to update consumers such as git instead of
a single system-provided tool.

One worry is that, if on_ac_power is not installed, other sources known by
this hook likewise assume that unknown means battery.  And for example on
Debian, powermgmt-base (which is where on_ac_power lives) is no longer
installed by default.  This suggests this patch needs to be extended to
cover the other sources as well, but let's discuss this first.  Extra
commits are cheap...

> > Reported by: Xin Li <delphij@google.com>
> > Signed-off-by: Adam Borowski <kilobyte@angband.pl>
> > ---
> >  contrib/hooks/pre-auto-gc-battery | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/contrib/hooks/pre-auto-gc-battery b/contrib/hooks/pre-auto-gc-battery
> > index 6a2cdebdb..7ba78c4df 100755
> > --- a/contrib/hooks/pre-auto-gc-battery
> > +++ b/contrib/hooks/pre-auto-gc-battery
> > @@ -17,7 +17,7 @@
> >  # ln -sf /usr/share/git-core/contrib/hooks/pre-auto-gc-battery \
> >  #	hooks/pre-auto-gc
> >  
> > -if test -x /sbin/on_ac_power && /sbin/on_ac_power
> > +if test -x /sbin/on_ac_power && (/sbin/on_ac_power;test $? -ne 1)
> >  then
> >  	exit 0
> >  elif test "$(cat /sys/class/power_supply/AC/online 2>/dev/null)" = 1
> 


[1]. I don't know if there's an implementation of on_ac_power for OSX, but
if there is, it is reasonable to assume it uses or emulates pmset.

[2]. Technically, that's _dc_ not ac power, but as batteries use a different
interface, in the vast majority of cases USB power can be considered
non-rationed.  You can power it from an unplugged laptop or from a
powerbank, but that's no different from "mains" that come from an unplugged
UPS with no or unsupported control link.
-- 
⢀⣴⠾⠻⢶⣦⠀ 
⣾⠁⢠⠒⠀⣿⡁ A dumb species has no way to open a tuna can.
⢿⡄⠘⠷⠚⠋⠀ A smart species invents a can opener.
⠈⠳⣄⠀⠀⠀⠀ A master species delegates.
