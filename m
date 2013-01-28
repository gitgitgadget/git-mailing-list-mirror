From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 01/11] sequencer.c: rework search for start of footer
 to improve clarity
Date: Sun, 27 Jan 2013 17:27:48 -0800
Message-ID: <20130128012748.GD8206@elie.Belkin>
References: <1359335515-13818-1-git-send-email-drafnel@gmail.com>
 <1359335515-13818-2-git-send-email-drafnel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, pclouds@gmail.com, gitster@pobox.com
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 02:28:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzdWC-0002SH-RX
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 02:28:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757229Ab3A1B14 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2013 20:27:56 -0500
Received: from mail-da0-f51.google.com ([209.85.210.51]:39051 "EHLO
	mail-da0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755670Ab3A1B1y (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 20:27:54 -0500
Received: by mail-da0-f51.google.com with SMTP id i30so993447dad.10
        for <git@vger.kernel.org>; Sun, 27 Jan 2013 17:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=0WuOft4epoYaF4/kDcSJTNcdKMpQqaynmVU8AKXyL7Q=;
        b=G12SVJMmoREExIAjiMeOR9oDC8P9TOORwjJA0wpleBVHHdGSdtYxEjKAnDABAjEhd9
         qsSxvdbmRSOTv/Di39GU7tkHnFyNwU/xq0EikV7KhBKp/oBU6lbHluRkS3+bnPtK/J/4
         iVHb1Q7l9909Xhb7uUQJSOqxEJTkYXWKlYkb1gO4SbMR797O7O//fMplr7q2Bog5BRxB
         C7lHjUJp2UUGEEk0ZXUdDe+j9w0ZPc0o3sHLWX5WzhJ8TD4qFPYgzSt4PFmuBf8sfyUU
         JN4bUnGR56asyygzRbH2riTDeZ8bsZCiL3/pGZdVWrv39I1dqeYxUe+HbBpExCLFIFpP
         heeg==
X-Received: by 10.68.143.195 with SMTP id sg3mr12000888pbb.137.1359336474074;
        Sun, 27 Jan 2013 17:27:54 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id ug6sm5239047pbc.4.2013.01.27.17.27.51
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 27 Jan 2013 17:27:52 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1359335515-13818-2-git-send-email-drafnel@gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214781>

Brandon Casey wrote:

> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -1024,16 +1024,19 @@ int sequencer_pick_revisions(struct replay_opts *opts)
>  static int ends_rfc2822_footer(struct strbuf *sb, int ignore_footer)
>  {
>  	int ch;
> -	int hit = 0;
> +	int last_char_was_nl, this_char_is_nl;
>  	int i, j, k;
>  	int len = sb->len - ignore_footer;
>  	int first = 1;
>  	const char *buf = sb->buf;
>  
> +	/* find start of last paragraph */
> +	last_char_was_nl = 0;
>  	for (i = len - 1; i > 0; i--) {
> -		if (hit && buf[i] == '\n')
> +		this_char_is_nl = (buf[i] == '\n');
> +		if (last_char_was_nl && this_char_is_nl)
>  			break;
> -		hit = (buf[i] == '\n');
> +		last_char_was_nl = this_char_is_nl;

I would have been tempted to write

	char prev;

	prev = 0;
	for (i = len - 1; i > 0; i--) {
		char ch = buf[i];
		if (prev == '\n' && ch == '\n')	/* paragraph break */
			break;
		prev = ch;
	}

but your rewrite is just as clear.  For what it's worth,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
