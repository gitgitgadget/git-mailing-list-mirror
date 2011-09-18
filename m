From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC] fast-import: note deletion command
Date: Sun, 18 Sep 2011 15:35:06 -0500
Message-ID: <20110918203506.GG2308@elie>
References: <CA+gfSn9sdTzQghqQp6hcO-9kN9mPx2JLRig79Rgx2FqGWXXp=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, David Barr <davidbarr@google.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Thomas Rast <trast@student.ethz.ch>,
	Johan Herland <johan@herland.net>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Dmitry Ivankov <divanorama@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 18 22:35:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5O5K-0001LG-Hs
	for gcvg-git-2@lo.gmane.org; Sun, 18 Sep 2011 22:35:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756437Ab1IRUfM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Sep 2011 16:35:12 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:54371 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756059Ab1IRUfL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Sep 2011 16:35:11 -0400
Received: by iaqq3 with SMTP id q3so4537864iaq.19
        for <git@vger.kernel.org>; Sun, 18 Sep 2011 13:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=hh0pDSd+ruU4tY53AVDzH/Il8/8I6Y4N79ObneYuBHU=;
        b=j4czpm7Y/Z1KAB/t6RfoVlpVoZnJ9luAMpTRnPdGZUR/w9DXpCZy6dOC51qAcQH5Al
         CwENG+1bBRIApjWtrG/LfnB74ND45CslFgky/v9q/JIENB27LHNlG1QYIywkvh00GK04
         LMHVMj3TFSnrtwHaz1nGHi6EV/DBU3a888NCA=
Received: by 10.42.168.198 with SMTP id x6mr3083348icy.148.1316378110392;
        Sun, 18 Sep 2011 13:35:10 -0700 (PDT)
Received: from elie (99-120-124-35.lightspeed.cicril.sbcglobal.net. [99.120.124.35])
        by mx.google.com with ESMTPS id by18sm10378377ibb.1.2011.09.18.13.35.08
        (version=SSLv3 cipher=OTHER);
        Sun, 18 Sep 2011 13:35:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CA+gfSn9sdTzQghqQp6hcO-9kN9mPx2JLRig79Rgx2FqGWXXp=A@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181635>

(+cc: Sverre for fast-import, Johan for notes, Thomas as a user of
 the note import feature, snipping less for their benefit)

Dmitry Ivankov wrote:

> Hi,
>
> fast-import is able to write notes provided a command
> N <note_content_data_specification> <commit_specification>
>
> There is no documented command to delete a note. It can't be
> easily replaced with Delete command on notes tree because
> of notes fanout.
>
> But fast-import interprets 0{40} data_specification as a note
> deletion command. It is consistent with fast-import internals
> where null_sha1 is used for absent/unknown object. But is
> not consistent with file Modify command nor looks like a common
> convention in git ui.

Right.

> So the questions are:
> - should 0{40} not be treated as deletion toggle? Downside is that
> it is used as one in t/t9301-fast-import-notes.sh.
> - how should a documented way to delete notes look like?
> ND commit_sha1 # One may think there are also NC, NR, NM
> N delete commit_sha1
> # Only :mark, full-40-byte-sha1 and 'inline' are allowed currently.
> # So no clashes arise, but then one may also want M 'delete' path
> # command to work too.

If I were doing it:

 - advertise "N 0{40} <commit>" as the historical way to delete a
   note, and make sure it keeps working

 - introduce 'ND' or 'notedelete <commit>' as a human-friendly
   synonym, keeping in mind that NC and NR could be introduced in the
   future if there is demand for them.

 - don't add any new magic "N <magic keyword> <commit>" commands,
   since it's hard to know when they will clash with some VCS's
   convention for object names.

I imagine there are plenty of other acceptable ways to accomplish
these things, though. :)  Thanks for looking into it.
