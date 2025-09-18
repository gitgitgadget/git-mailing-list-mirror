Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005462820B7
	for <git@vger.kernel.org>; Thu, 18 Sep 2025 17:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758218290; cv=none; b=LbKFJnrD+2+/KqmCP+tgdV+I/fEVfWcXWK6iXlffe2Q+DUv/odWYo2iiMSbDkd2Q3rAvFzyvib6RD4T7AEwamNqMuMh3vzPT1dCG81z7IIwp9181Lpo1jRXOB1wlEbeieQisC7d7z8SXfCS8ZZUqOWGGPkgaDWmQzyNzI9zshRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758218290; c=relaxed/simple;
	bh=tXm+g+b16h6ZKBmT9iLKQzOvmniu4HxQ1+ZQPMlgHW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YbwRRJzmKfBgx2VBRkJKxpXYiHpfDpI7nfgrOTolJzti5vptpCav7GV3YHzcMbHnd+L7sVJu9cP0BgBlCek3H2b0qlK4JHNvxu9cVHfxsqDyYUPPI3W9pcABj60GV5nIWnogp1z+A3nNYi9UD73ZLZ5lnezt+gHWyHMwQUXsVB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.104] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4cSNdz1PVwzRnmN;
	Thu, 18 Sep 2025 19:57:59 +0200 (CEST)
Message-ID: <3fd3f64f-6ab7-4b4a-a834-a9c5c1e89d5b@kdbg.org>
Date: Thu, 18 Sep 2025 19:57:58 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gitk: make the 'Tags and Heads' window geometry sticky
To: Michael Rappazzo <rappazzo@gmail.com>, git@vger.kernel.org
References: <20250913181153.46575-1-rappazzo@gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <20250913181153.46575-1-rappazzo@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 13.09.25 um 20:10 schrieb Michael Rappazzo:
> Currently, the Tags and Heads window always opens at a default position
> and size, requiring users to reposition it each time. 
> 
> This change saves and restores the Tags and Heads window size and position
> relative to the main gitk window. The geometry is stored in the config file
> as `geometry(showrefs)` and persists between gitk sessions. The window
> position is stored relative to the main window, so it maintains the same
> spatial relationship when the main window is moved or when gitk is restarted
> on different monitors.

Thank you for this patch. In general, I like the direction this is
going. I am baffled, though, by the sheer number of lines that must be
added to achieve the goal.

I tested the patch Windows and Linux (KDE), and found some deficiencies
on both.

During a session, on Windows, size and position are retained and on
Linux, only the size is retained (the position is always the default).
In both environments, persistence across session happens only when Gitk
is closed while the Tags and Heads window is open, but not when it is
closed via any of the means available.

To reduce the code a bit, would it be possible to set the global
geometry(showrefs) from a handler of the Configure event? Then it does
not have to be set on any other occasion.

> 
> Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>
> ---
>  gitk | 75 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 73 insertions(+), 2 deletions(-)

> +proc parse_geometry {geom_string} {
> +    if {[regexp {^(\d+)x(\d+)\+(-?\d+)\+(-?\d+)$} $geom_string -> w h x y]} {
> +        return [list $w $h $x $y]
> +    }
> +    return {}
> +}

Are there any occasions where it is expected that the regular expression
does not match? If not, let's fail with an error. Then we don't have to
verify the return value at the call sites.

> +proc restore_showrefs_geometry {top} {
> +    global geometry
> +
> +    if {![info exists geometry(showrefs)] || ![winfo exists $top] || ![winfo exists .]} return
> +
> +    set saved_geom [parse_geometry $geometry(showrefs)]
> +    set main_geom [parse_geometry [wm geometry .]]
> +    if {[llength $saved_geom] == 4 && [llength $main_geom] == 4} {
> +        lassign $saved_geom w h rel_x rel_y
> +        lassign $main_geom mw mh mx my
> +
> +        set abs_x [expr {$mx + $rel_x}]
> +        set abs_y [expr {$my + $rel_y}]
> +
> +        # Ensure window stays on screen
> +        set screen_w [winfo screenwidth .]
> +        set screen_h [winfo screenheight .]
> +        if {$abs_x < 0} { set abs_x 0 }
> +        if {$abs_y < 0} { set abs_y 0 }
> +        if {$abs_x + $w > $screen_w} { set abs_x [expr {$screen_w - $w}] }
> +        if {$abs_y + $h > $screen_h} { set abs_y [expr {$screen_h - $h}] }

Consider the case where the stored height exceeds $screen_h. The title
bar is moved out of the screen due to the order of these corrections.
Let's correct the lower and right bounds first, and the upper and left
bounds second. Then the title bar stays on the screen.

> +
> +        wm geometry $top "${w}x${h}+${abs_x}+${abs_y}"
> +    }
> +    bind $top <Map> {}
> +}
-- Hannes

