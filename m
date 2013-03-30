From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [RFC] Add posibility to preload stat information.
Date: Sat, 30 Mar 2013 15:42:07 -0400
Message-ID: <CABURp0rAp_s1jDdhohZ44+6RXNW_A4JirAaVwfiCL9Jf2ZmiZA@mail.gmail.com>
References: <1363781732-11396-1-git-send-email-iveqy@iveqy.com>
 <20130320164806.GA10752@sigill.intra.peff.net> <7vhak6f0w4.fsf@alter.siamese.dyndns.org>
 <20130320174759.GA29349@sigill.intra.peff.net> <87vc8lyqz7.fsf@pctrast.inf.ethz.ch>
 <7vtxo4byng.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>,
	Fredrik Gustafsson <iveqy@iveqy.com>,
	Shawn Pearce <spearce@spearce.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	=?UTF-8?B?RHV5IE5ndXnhu4Vu?= <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 30 20:43:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UM1gB-0006pX-2I
	for gcvg-git-2@plane.gmane.org; Sat, 30 Mar 2013 20:43:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757113Ab3C3Tm3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Mar 2013 15:42:29 -0400
Received: from mail-vc0-f179.google.com ([209.85.220.179]:39403 "EHLO
	mail-vc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756589Ab3C3Tm2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Mar 2013 15:42:28 -0400
Received: by mail-vc0-f179.google.com with SMTP id gf12so1337508vcb.38
        for <git@vger.kernel.org>; Sat, 30 Mar 2013 12:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=fCpKrntHp3QG3yzN10vQ7ly1ugEPKtCWYsiXWj2rn5M=;
        b=i/7t4hhTKP8IX9kayRjWB37LV7vQJMGMlwGsMbyIkjYik+lzmIQehN2NK+tm3wQm7c
         yHgkfwQCY4mANdwNNMhSrg4fVj0Cx2lWqUWz094NGEVEgygL1cfx8Jna8OVGqPDRD7Gj
         42PhrVZZJZ6j7SHGe2pAKlqRNEZMPAegyFaDfQFKKtE9dR+MHj6I68pzvMDTGTshNj1+
         UlbZqHBENxI71tffEcV1jP6eQrvDhayGHxKAfhNEX6zigFzPJ0k0BajNBCS9VCBsHhzH
         zyQk4u2f0K3MjC1F1k/R8gqXHJBdfQrqJWGPv/0M50wBf1eL3C0Is2Bmt9Y5ZEIrOQCx
         FWAQ==
X-Received: by 10.52.26.209 with SMTP id n17mr4541521vdg.26.1364672547772;
 Sat, 30 Mar 2013 12:42:27 -0700 (PDT)
Received: by 10.58.23.135 with HTTP; Sat, 30 Mar 2013 12:42:07 -0700 (PDT)
In-Reply-To: <7vtxo4byng.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219595>

On Thu, Mar 21, 2013 at 10:44 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Thomas Rast <trast@student.ethz.ch> writes:
>
>> I think it would actually be a somewhat interesting feature if it
>> interacted with GIT_PS1_SHOW*.  If you use these settings (I personally
>> use SHOWDIRTYSTATE but not SHOWUNTRACKEDFILES), the prompt hangs while
>> __git_ps1 runs git-status.  It should be possible to run a git-status
>> process in the background when entering a repository, and displaying
>> some marker ('??' maybe) in the prompt instead of the dirty-state info
>> until git-status has finished.
>
> This is somewhat interesting.
>
> Perhaps we can introduce a helper binary that does what __git_ps1()
> does, with a --timeout=500ms option to say "I dunno (yet)", and keep
> priming the well in the background when it takes more than the
> specified amount of time?

That would be nice.  My fork-fu is weak, so I cheated and relied on
kill/timeout instead.

I have had this code below in my zsh git prompt (based on oh-my-zsh)
for more than a year.  It uses $(timeout) to kill the status command
if it does not complete in 1 second.  It's dumb in several ways, but
it does show me four different flags fairly reliably indicating
whether I have changed files, untracked files, clean workdir, or I
timed out trying to find out.

git_dirty_timeout () {
  #-- Modified files
  xx=$(timeout 1s git status -s $@ 2> /dev/null)
  test $? -eq 124 && return 124
  test -n ${xx} && return 50

  #-- Untracked files (only)
  xx=$(timeout 1s git status -s -uno $@ 2> /dev/null)
  test $? -eq 124 && return 124
  test -n ${xx} && return 51
  return 0
}

parse_git_dirty () {
  git_dirty_timeout
  case "$?" in
        '50')  echo "$ZSH_THEME_GIT_PROMPT_DIRTY"       ;;
        '51')  echo "$ZSH_THEME_GIT_PROMPT_UNTRACKED"   ;;
        '124') echo "$ZSH_THEME_GIT_PROMPT_TIMEOUT"     ;;
        *)     echo "[$?]$ZSH_THEME_GIT_PROMPT_CLEAN"   ;;
  esac
}
