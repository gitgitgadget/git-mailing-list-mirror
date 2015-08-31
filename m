From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH] commit: don't rewrite shared index unnecessarily
Date: Mon, 31 Aug 2015 14:41:31 -0400
Organization: Twitter
Message-ID: <1441046491.25570.13.camel@twopensource.com>
References: <1440695274-12400-1-git-send-email-dturner@twopensource.com>
	 <CACsJy8D=KyWBYf1LW=n928rmG=9xavSaR+1G1g+F7mMTKFCpfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 31 20:41:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWU1U-0002vd-AJ
	for gcvg-git-2@plane.gmane.org; Mon, 31 Aug 2015 20:41:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753880AbbHaSlg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2015 14:41:36 -0400
Received: from mail-qg0-f42.google.com ([209.85.192.42]:36071 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751701AbbHaSlf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2015 14:41:35 -0400
Received: by qgeb6 with SMTP id b6so71296263qge.3
        for <git@vger.kernel.org>; Mon, 31 Aug 2015 11:41:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=Q1NZZwPSO+pEga5frTtI2N28kv55l6NUCcLZhGiElzo=;
        b=i46Ien4K3Y3iXPmlheGQi34HTm3jmOaezEr/v3geMn/hFqIiZCJCdiO2YE9iLBqImy
         kqIYHx6vBPvjW8M/hpu13Zr1tWcDKBW1bwnEIrKEcZXmTYBIBPcTzr93yAvO4b3RaQhO
         Ybc2jpczzntlkZFIteg+TZi53Y2+NxAzWXHT5VTD8uevduYNLE/tRFLvOf0rZW+K4gae
         Y2uyblaqlgK2KLGVorIzTJjS0uWg68P3GaKVAkGJnywB3bFKnwwC9vOKDIZZ5TyJpCiX
         WaLZRa+8U+fSoLUXk8lL16ZgWa3pzmjqWirSLLasS6ee46WeVHj2rXjtc3ToQVOv/AjM
         KPsw==
X-Gm-Message-State: ALoCoQkc8EYAVYyFFtdQKC69icj/dicC+v5nsLcTIcu3ouCjluOT11CavW5fnIN5VoQDWsQ4VXqB
X-Received: by 10.140.239.135 with SMTP id k129mr42149146qhc.55.1441046494845;
        Mon, 31 Aug 2015 11:41:34 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id s64sm9297494qgs.33.2015.08.31.11.41.34
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Aug 2015 11:41:34 -0700 (PDT)
In-Reply-To: <CACsJy8D=KyWBYf1LW=n928rmG=9xavSaR+1G1g+F7mMTKFCpfg@mail.gmail.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276905>

On Mon, 2015-08-31 at 17:02 +0700, Duy Nguyen wrote:
> On Fri, Aug 28, 2015 at 12:07 AM, David Turner <dturner@twopensource.com> wrote:
> > Remove a cache invalidation which would cause the shared index to be
> > rewritten on as-is commits.
> >
> > When the cache-tree has changed, we need to update it.  But we don't
> > necessarily need to update the shared index.  So setting
> > active_cache_changed to SOMETHING_CHANGED is unnecessary.  Instead, we
> > let update_main_cache_tree just update the CACHE_TREE_CHANGED bit.
> >
> > In order to test this, make test-dump-split-index not segfault on
> > missing replace_bitmap/delete_bitmap.  This new codepath is not called
> > now that the test passes, but is necessary to avoid a segfault when the
> > new test is run with the old builtin/commit.c code.
> >
> > Signed-off-by: David Turner <dturner@twopensource.com>
> 
> Ack.
> 
> I made SOMETHING_CHANGED "1" for catching these cases (there were a
> few on-flight topics when this series was being cooked and I was
> afraid I could not cache all active_cache_changed sites).
> 
> > ---
> >
> > I introduced this bug last year while improving the cache-tree code.
> > I guess I probably didn't notice that active_cache_changed wasn't a
> > boolean.
> 
> So.. you did you split-index? Cool. Never heard anyone using it for
> real. It needs the other part to improve reading/refresh side to get
> to full potential though..

I am experimenting with an "unskipped index", to reduce the cost of
index loading and processing in sparse checkouts.  The unskipped index
is an index on the (v3) index -- that is, it lists the byte offsets of
all entries in the sharedindex where CE_SKIP_WORKTREE is 0.  In
addition, there is a list of the offsets of *all* entries, which we can
binary search in.  There's also some other metadata that I'm figuring
out as I go along.  This might allow us to avoid loading the full shared
index in most cases.  Or it might be a total dead end.  Not sure yet.
