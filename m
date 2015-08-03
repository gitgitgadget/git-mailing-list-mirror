From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v5 2/5] refs: add ref_type function
Date: Mon, 03 Aug 2015 16:44:49 -0400
Organization: Twitter
Message-ID: <1438634689.7348.35.camel@twopensource.com>
References: <1438322781-21181-1-git-send-email-dturner@twopensource.com>
	 <1438322781-21181-2-git-send-email-dturner@twopensource.com>
	 <CACsJy8DK9k67yM_mJqbqgDxNKdGKpoLPOQQ4beqGgzUobzyFUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 03 22:45:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMMbV-0004hx-04
	for gcvg-git-2@plane.gmane.org; Mon, 03 Aug 2015 22:45:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755532AbbHCUoz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2015 16:44:55 -0400
Received: from mail-qg0-f53.google.com ([209.85.192.53]:35405 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753741AbbHCUow (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2015 16:44:52 -0400
Received: by qgii95 with SMTP id i95so97550838qgi.2
        for <git@vger.kernel.org>; Mon, 03 Aug 2015 13:44:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=UcXKJ7SjDgXS5pbpU5BS6wpsmitQ/TCWPOVlxTuRV4k=;
        b=jibdWM8Q8L+1kW7hRaJj+iQS3FRmFOcggefLW/sR4/jCj1U8+rlcP3IZdsM5olZ4b5
         ofa0afS81qrw8NNjJt4e5nU8JETS+K3zS52U3mINrfhtEANoWexbtbHK9QwfgtBTG7RV
         SMbX9+Nif6SUs3Cpo0QH4Wr/FsvvEp5Zxl4B9e800320OQyynx47l8GRxe0yUPa6U6X0
         Ery0D2LTlfGrJHGWr24fSvpCU6NAkz/BoxewZrYT3j4dE4NMhct2LlCdDTXOlJaDoxql
         hWHzwRrEnI+0VwL35y0A4nLc8utcefrDfkHhezKGqwZAC6medoZtq/bXuVv5Wgi3vKoY
         Cv/A==
X-Gm-Message-State: ALoCoQlg2YAKbT/ZHbGGb7UR+AZRkSo5pEiBbHCtJYbxuiI0U4UiMYYlF7G1q6ICubYYiDrj0yzi
X-Received: by 10.140.96.80 with SMTP id j74mr27514378qge.43.1438634691348;
        Mon, 03 Aug 2015 13:44:51 -0700 (PDT)
Received: from ubuntu ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id w105sm7478687qgd.12.2015.08.03.13.44.49
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Aug 2015 13:44:50 -0700 (PDT)
In-Reply-To: <CACsJy8DK9k67yM_mJqbqgDxNKdGKpoLPOQQ4beqGgzUobzyFUQ@mail.gmail.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275197>

On Mon, 2015-08-03 at 20:55 +0700, Duy Nguyen wrote:
> On Fri, Jul 31, 2015 at 1:06 PM, David Turner <dturner@twopensource.com> wrote:
> > Add a function ref_type, which categorizes refs as per-worktree,
> > pseudoref, or normal ref.
> 
> For per-worktree refs, you probably should follow common_list[] in
> path.c because that's how file-based ref namespace is splitted between
> per-repo and per-worktree, even though just as simple as "everything
> outside refs/ is per-worktree" (with an exception of NOTES_MERGE_REF,
> which should be on the list as well). At least the two should be
> aligned so that the default file-based backend works the same way as
> new backends.

That would be cleaner, I think.  I'm maybe a little worried about
performance if we do this, but I guess we could optimize later. 

Before I re-roll, I'll wait until we come to a conclusion on the 
other per-worktree ref thread.

I think we discussed NOTES_MERGE_REF[1], and decided that it should work
like HEAD.  Does that seem right to you?

> Going further, I think you need to pass the "worktree identifier" to
> ref backend, at least in ref_transaction_begin_fn. Each backend is
> free to store per-worktree refs however it wants. Of course if I ask
> for refs/foo of worktree A, you should not return me refs/foo of
> worktree B. ref_transaction_begin_fn can return a fault code if it
> does not support multiple worktrees, which is fine.

If we did that, we would have to add it all over the place -- not just
ref_transaction_begin, but also update_ref.  

I think it's better to encapsulate this knowledge inside the refs code.

> > Later, we will use this in refs.c to treat pseudorefs specially.
> > Alternate ref backends may use it to treat both pseudorefs and
> > per-worktree refs differently.
> 
> I'm not so sure that this can't be hidden behind backends and they can
> have total control on falling back to file-based, or store them in
> some secondary storage. I haven't re-read your discussion with Junio
> yet (only skimmed through long ago) so I may be missing some important
> points.

The worry is symbolic refs -- a symbolic ref might be a per-worktree ref
pointing to a shared ref pointing to a per-worktree ref.  This is why
it's simpler to let backends handle things.  If we had some rules about
this, we could maybe hide this from the backend, but so far, this was
the simplest thing to do (it works great!).


[1] http://www.spinics.net/lists/git/msg256793.html
