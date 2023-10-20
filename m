Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24831200BF
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 18:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="kX3mH42j"
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CAF8114
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 11:48:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1697827692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XcRvMoWFuXuI55jn9kKDb+NjSIN/y+liTp0mejgYV2A=;
	b=kX3mH42j1VB8Jw8oaHA+R1OiLCBTH0fC0tB4mVyXEbnLnMhFnbtk0RyXYI1GStaWh7/0pu
	W6Zmkr1HiXlCSStoV13dCr9MXXB9TM/wTOXJtBI87MCERdjXIxwyx+7d7Yoip424rBVEy5
	vcKuJrc/AOB6PW7sFPqklt75nXmeyQnQi92P+rxqN5jNwHCNykJ+6A5OecaN9qGDQyXaZD
	Fu1ocMiIEBCrmbs4xQSFmniBosyS5EAW+yTO4rwpZmn+KYJ9JqGSbZS8JpaZRneOLDveHq
	83sRzk69HzKVmsscnvttsEtIKbQetKrZ8iiO+5xws+TM+eAyqaIQGKsniesEeQ==
Date: Fri, 20 Oct 2023 20:48:12 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Jacob Stopak <jacob@initialcommit.io>
Cc: git@vger.kernel.org
Subject: Re: [RFC PATCH 0/5] Introduce -t, --table for status/add commands
In-Reply-To: <20231020183947.463882-1-jacob@initialcommit.io>
References: <20231020183947.463882-1-jacob@initialcommit.io>
Message-ID: <fd26df85661d554ced9d8e0445f75952@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2023-10-20 20:39, Jacob Stopak wrote:
> This is a proposal / proof-of-concept for a new table-based output
> format for the git status command, and for dry runs (-n) of the git add
> command. This could be extended to create visual dry runs for other
> other commands like rm, mv, restore, stash, commit, and clean.

Huh, please don't get me wrong, but based on the examples provided 
below, I really think that's only wasted screen estate, providing little 
or no help in understanding the performed operations.

I appreciate your effort, but IMHO it makes little sense from the 
usability standpoint.

> For some context, earlier this year I released a tool called Git-Sim
> (https://github.com/initialcommit-com/git-sim) which allows users to do
> visual dry runs of many Git commands, which are rendered as high 
> quality
> output image files. Simulating commands like status, add, rm, mv, 
> restore,
> stash, and commit creates a table with 3 columns to represent the way 
> file
> changes "move around" as a result of the command being simulated.
> 
> I've gotten positive feedback from users about this visual approach to
> simulating git commands, which is more intuitive than pure terminal 
> text
> for both newer users to understand how git works and for visual people.
> 
> As a result, I was thinking of ways to integrate these types of visual
> formats directly into Git. A table-based output format with colored
> highlighting for the commands mentioned above is low hanging fruit.
> 
> Teach 'git status' the new -t, --table flag, which displays the status
> output in a 3-column table format, preserving terminology and color
> coding from the default git status "long output" format (note that the
> column headers are shortened here for the small width of this email, 
> and
> also I just realized that the tables below might not look right on the
> mailing list due to the differing character width, but it looks correct
> in the terminal so please test there it's more fun anyway :D):
> 
> $ git status -t
> -------------------------------------------------------------------------
> |    Untracked files    | Changes n...or commit | Changes t...committed 
> |
> -------------------------------------------------------------------------
> |         poiu          |                       |                       
> |
> |     status-table/     |                       |                       
> |
> |                       |                       |         asdf          
> |
> |                       |        table.c        |                       
> |
> |                       |      wt-status.c      |                       
> |
> -------------------------------------------------------------------------
> 
> Teach 'git add' the new -t, --table flag to be used ONLY in combination
> with the '-n' flag for dry runs. Instead of simply printing out the
> added filenames, the full status table format is displayed, along with
> arrows that visually show how the added files are being moved around:
> 
> $ git add -nt poiu wt-status.c
> -------------------------------------------------------------------------
> |    Untracked files    | Changes n...or commit | Changes t...committed 
> |
> -------------------------------------------------------------------------
> |         poiu -----------------------------------------> poiu          
> |
> |     status-table/     |                       |                       
> |
> |                       |                       |         asdf          
> |
> |                       |        table.c        |                       
> |
> |                       |      wt-status.c ----------> wt-status.c      
> |
> -------------------------------------------------------------------------
> 
> Other notes:
> 
> * The width of the table and columns are dynamically set based on the
>   width of the terminal.
> 
> * Long paths are shortened to include the maximum number of characters
>   from both ends of the path that will fit, with a '...' in the middle.
> 
> * Color coding matches the default output of 'git status', with
>   untracked files and working dir mods in red, and staged changes in
>   green. If needed, arrows are drawn in cyan.
> 
> As stated above, the dry run version of the table format can be applied
> to various other commands like rm, mv, restore, stash, commit, and 
> clean
> which all move file changes around in a way that can be represented in
> the table format. New columns may need to be added or arrows reversed
> to show changes moving in various directions. Note that some of these
> commands don't appear to have a dry run (-n) option yet, so it could be
> added for consistency (if not already in use) and for use with the new
> table format.
> 
> Since this is an RFC patch series, I probably did some illegal and dumb
> things in my code changes just to get it into a demo-able state. I am a
> bit wary of having made changes to files like "read-cache.c" and
> "read-cache-ll.h" to pass in the wt_status info, and there are probably
> betters ways to do some other things too.
> 
> Feedback on both the new format itself and the implementation is very
> much appreciated!
> 
> Jacob Stopak (5):
>   status: introduce -t, --table flag
>   status: handle long paths with -t, --table flag
>   status: add advice arg for -t, --table flag
>   add: add -t, --table flag for visual dry runs
>   add: set unique color for -t, --table arrows
> 
>  Makefile         |   1 +
>  builtin/add.c    |  46 +++++++--
>  builtin/commit.c |   4 +-
>  read-cache-ll.h  |   9 +-
>  read-cache.c     |  32 ++++++-
>  table.c          | 245 +++++++++++++++++++++++++++++++++++++++++++++++
>  table.h          |   6 ++
>  wt-status.c      |  74 +++++++++-----
>  wt-status.h      |   3 +
>  9 files changed, 378 insertions(+), 42 deletions(-)
>  create mode 100644 table.c
>  create mode 100644 table.h
