From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/8] vcs-svn: Introduce repo_read_path to check the
 content at a path
Date: Sun, 6 Mar 2011 06:29:42 -0600
Message-ID: <20110306122942.GA18995@elie>
References: <20101118050023.GA14861@burratino>
 <20101120004525.GA17445@burratino>
 <20101120192153.GA17823@burratino>
 <20101120192528.GD17823@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	David Barr <david.barr@cordelta.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 06 13:29:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwD5w-0003Mm-9L
	for gcvg-git-2@lo.gmane.org; Sun, 06 Mar 2011 13:29:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753494Ab1CFM3v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Mar 2011 07:29:51 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:61657 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751553Ab1CFM3t (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Mar 2011 07:29:49 -0500
Received: by iyb26 with SMTP id 26so3181279iyb.19
        for <git@vger.kernel.org>; Sun, 06 Mar 2011 04:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=gPQ+TvqJz4FQfUw0tVGd+sAWMLApwMMOIVnQW/YtIfc=;
        b=hjVO0zKP/RlvZ88fi9DSBFLGh0J63RJS4HOc+ntS5lE5ZTm3wxWE816Pd2pFBzKE9R
         ZmgcXYyIgoDDDi+KzjXJf8VYYX9UiEfuRmLU5Ri7IuS+ssijks045kqvl3ryM7Qd2as5
         AVTrB/CJJNsT4Tn6Uc3z2ITVqs+fAH9xk5pfM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Wr81BQJWEA8uRYUWXDtHM1FbG0JKqqvLUNwL95IkE3lnXIFfhyx/Qcz/wXm8fBUkz6
         T0s/Oik9SSC4UZOvA342FWzzIA6OGsP+frdQg9yUTo0y6iKlKWUd33RBKbEkhYrwiGsm
         rHyiHRccP6ETqYSIOvPHtU2Ko8sTJhM17FqnY=
Received: by 10.43.50.5 with SMTP id vc5mr3632791icb.60.1299414588917;
        Sun, 06 Mar 2011 04:29:48 -0800 (PST)
Received: from elie (adsl-69-209-74-158.dsl.chcgil.ameritech.net [69.209.74.158])
        by mx.google.com with ESMTPS id jv9sm1514617icb.1.2011.03.06.04.29.46
        (version=SSLv3 cipher=OTHER);
        Sun, 06 Mar 2011 04:29:47 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101120192528.GD17823@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168515>

Hi,

Jonathan Nieder wrote:

> repo_modify_path returns the mode.
>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>

Another cryptic commit message.

A long-winded explanation follows.  Please feel free to ignore it, or
even better, come up with a summary to use as change description that
people can refer to for this patch in the future. :)

It is currently possible to _modify_ both the mode and the text at a
path but there is only public functionality to retrieve the mode.  In
its original context, this patch added analogous functionality to
retrieve the text (indexed by a blob name) as preparation for applying
a delta to it.

In the vcs-svn-incremental series, it will allow us to restructure
handle_node() a little: instead of making little modifications to an
in-memory cache managed by the repo-tree library (saying, "change the
mode this way but keep the content; now keep the mode but change the
content"), handle_node can take responsibility for figuring out what
will be the final mode and content for the path in question.

In other words, a later patch will change handle_node (in the
Node-action: change case) from looking like

	/* Change text at path. */
	mode = repo_modify_path(path, 0, have_text ? text : 0);

	/* Change mode at path. */
	if (have_props) {
		read_props(&new_mode);
		if (new_mode != mode)
			repo_modify_path(path, new_mode, have_text ? text : 0);
	}

to

	/* Determine desired text and mode at path. */
	old_text = repo_read_path(path);
	old_mode = repo_modify_path(path, 0, 0);
	if (have_props)
		read_props(old_mode, &mode);
	if (!have_text)
		text = old_text;

	/* Make it so. */
	repo_add(path, mode, text);

It is also just nice to have a function like this, to make the API
less surprising.
