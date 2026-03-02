Received: from bsmtp2.bon.at (bsmtp2.bon.at [213.33.87.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D517F430B98
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 11:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772451063; cv=none; b=ipLpGm53wc8jn3O1UQJRP7IF9F9M/E9vDbOrIyFsXw+eWvqtJpM5qlfSXbAWoguLFZ1GuG1c3b76Ix5x/xdjQdZTWagKY4vDq6XVgKVznUFyesgTA9dvIU631mtIpFFyJLHaTiLIgzmZk+N0nl4prZ4Z1zE18LSZww/McaR7VfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772451063; c=relaxed/simple;
	bh=WGTWI17SUBfjMQ/4G2N2iXmQwtErnc+cYdgEanWsX7Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=o0+5nXFW+hN/ngLXC7JYTrtqhpGc3RauYSBI+M5cr/I/VygoGGLv1jYbXHjDfek4aId3OX3n/oWpAMXVY7WgXpxN8q7xhuMIJeDKsSvZ2Zeg4xuLYdkzxeKjsZRX8ja2r+saQNCUOrZ8sToFVdjw6fuglwgBogpJvAFR4tc7I4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.103] (unknown [93.83.142.38])
	by bsmtp2.bon.at (Postfix) with ESMTPSA id 4fPcF8582RzRnlW;
	Mon,  2 Mar 2026 12:30:52 +0100 (CET)
Message-ID: <08da87b1-32c6-43c2-be1f-d60bc93ea135@kdbg.org>
Date: Mon, 2 Mar 2026 12:30:51 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] git-gui: highlight comment lines in commit message
Content-Language: en-US
To: Wolfgang Faust <contrib-git@wolfgangfaust.com>
References: <a72715e2-c3ae-4050-95e3-7fc7f9b74b5d@app.fastmail.com>
From: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org
In-Reply-To: <a72715e2-c3ae-4050-95e3-7fc7f9b74b5d@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 01.03.26 um 22:55 schrieb Wolfgang Faust:
> These lines are stripped by wash_commit_message, but there is no indication
> in the UI that they are special and will be removed.
> Add highlighting to make it clear these lines are special.
> Signed-off-by: Wolfgang Faust <contrib-git@wolfgangfaust.com>

I like this idea! But please don't call it highlight, because we
actually want to do the opposite, dim or grey out the text.

Please leave a blank line above the sign-off trailer.

> (I'm not very good with tcl, so I suspect this code could use some work.
> In particular the regex being a mangled copy of the one in the wash
> procedure seems like a code smell, though I'm not sure how to improve
> it.)  

This text should go after the three-dashes, then it will be excluded
from the commit message.

> ---
>  git-gui/git-gui.sh | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
> index d3d3aa14a9..3a0c08aa38 100755
> --- a/git-gui/git-gui.sh
> +++ b/git-gui/git-gui.sh
> @@ -3900,6 +3900,25 @@ if {[winfo exists $ui_comm]} {
> 
>      backup_commit_buffer
> 
> +    # Grey out comment lines (which are stripped from the final
> commit message by

It looks like you pasted this text into your webmail client, which
destroyed the formatting of the patch. (I was able to fix this up,
but...) If you have a Github account, you could use Gitgitgadget
https://gitgitgadget.github.io/ for your submissions.

> +    # wash_commit_message).
> +    $ui_comm tag configure commit_comment -foreground gray
> +    proc highlight_commit_comment_lines {} {
> +        global ui_comm comment_string
> +        $ui_comm tag remove commit_comment 0.0 end
> +        set text [$ui_comm get 1.0 end]
> +        # See also cmt_rx in wash_commit_message
> +        set cmt_rx [strcat {(?:^|\n)(} [regsub -all {\W}
> $comment_string {\\&}] {[^\n]*)}]
> +        set ranges [regexp -all -indices -inline -- $cmt_rx $text]

The regular expression can be simplified if we use -line matching. Then
the initial (?:^|\n) can become just ^ (no parentheses), and since we do
not look at the end index, the trailing [^\n]* isn't needed, either.
Next, if we drop the capturing parentheses, only one pair of indexes is
reported per match...

> +        for {set i 1} {$i < [llength $ranges]} {incr i 2} {

... and we can turn this into a simple foreach loop...

> +            $ui_comm tag add commit_comment \
> +                [$ui_comm index "1.0 + [lindex [lindex $ranges $i] 0] chars"] \

... with just one level of indexing here. Also, we could stash away the
index computed here...

> +                [$ui_comm index "1.0 + [lindex [lindex $ranges $i] 0]
> chars lineend + 1 char"]

... and reuse it here with just the "lineend + 1char" modifier. (I
wonder why we need the +1char, though.)

> +        }
> +    }
> +    highlight_commit_comment_lines
> +    bind $ui_comm <<Modified>> { after idle highlight_commit_comment_lines }
> +
>      # -- If the user has aspell available we can drive it
>      #    in pipe mode to spellcheck the commit message.
>      #
> 
> base-commit: 7b2bccb0d58d4f24705bf985de1f4612e4cf06e5

-- Hannes

