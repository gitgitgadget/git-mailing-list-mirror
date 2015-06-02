From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: Bug in 'git am' when applying a broken patch
Date: Tue, 2 Jun 2015 10:26:14 +0900
Message-ID: <20150602012614.GD23370@kroah.com>
References: <20150601001759.GA3934@kroah.com>
 <xmqqwpzn5lht.fsf@gitster.dls.corp.google.com>
 <xmqqd21f5k7w.fsf@gitster.dls.corp.google.com>
 <CAPig+cTc72npgXUA9EirGonrjwhXCROxn4cc=6=uPywers_h9w@mail.gmail.com>
 <xmqq8uc35gap.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Gaston Gonzalez <gascoar@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 02 03:26:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzayE-000668-Vt
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 03:26:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754019AbbFBB0T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2015 21:26:19 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51821 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751211AbbFBB0R (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2015 21:26:17 -0400
Received: from localhost (p2208095-ipngn17401marunouchi.tokyo.ocn.ne.jp [153.224.29.95])
	by mail.linuxfoundation.org (Postfix) with ESMTPSA id 97795BBF;
	Tue,  2 Jun 2015 01:26:16 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <xmqq8uc35gap.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270501>

On Mon, Jun 01, 2015 at 01:23:26PM -0700, Junio C Hamano wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> 
> > s/enw/new/
> 
> Heh, thanks; I wasn't planning to commit this one yet, but why not.

Well, it's not good to apply a commit with no actual commit.  That
never a good thing, and was the thing that really confused me about this
issue.

> Here is with an updated log message and a test.
> 
> -- >8 --
> Subject: [PATCH] apply: reject a hunk that does not do anything
> 
> A hunk like this in a hand-edited patch without correctly adjusting
> the line counts:
> 
>      @@ -660,2 +660,2 @@ inline struct sk_buff *ieee80211_authentic...
>              auth = (struct ieee80211_authentication *)
>                      skb_put(skb, sizeof(struct ieee80211_authentication));
>      -       some old text
>      +       some new text
>      --
>      2.1.0
> 
>      dev mailing list
> 
> at the end of the input does not have a good way for us to diagnose
> it as a corrupt patch.  We just read two context lines and discard
> the remainder as cruft, which we must do in order to ignore the
> e-mail footer.  Notice that the patch does not change anything and
> signal an error.
> 
> Note that this fix will not help if the hand-edited hunk header were
> "@@ -660,3, +660,2" to include the removal.  We would just remove
> the old text without adding the new one, and treat "+ some new text"
> and everything after that line as trailing cruft.  So it is dubious
> that this patch alone would help very much in practice, but it may
> be better than nothing.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  builtin/apply.c        |  3 +++
>  t/t4136-apply-check.sh | 13 +++++++++++++
>  2 files changed, 16 insertions(+)

Looks good to me, thanks for fixing this, much appreciated.

greg k-h
