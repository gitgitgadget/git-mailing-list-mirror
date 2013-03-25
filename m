From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 5/9] add test for streaming corrupt blobs
Date: Mon, 25 Mar 2013 14:10:38 -0700
Message-ID: <20130325211038.GD1414@google.com>
References: <20130325201427.GA15798@sigill.intra.peff.net>
 <20130325202134.GE16019@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 25 22:11:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKEff-0005Qz-HD
	for gcvg-git-2@plane.gmane.org; Mon, 25 Mar 2013 22:11:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758616Ab3CYVKo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Mar 2013 17:10:44 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:55832 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752112Ab3CYVKn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Mar 2013 17:10:43 -0400
Received: by mail-pa0-f51.google.com with SMTP id jh10so601079pab.38
        for <git@vger.kernel.org>; Mon, 25 Mar 2013 14:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=FOxeZcq0IW+IQmgxGPcHjb5iSFTCz3TNquL8nae039w=;
        b=QoPr8TtjaB25O8G/XH8pdDr5afdaFDHrOLkWRVJBBxct3gKIQtO4wdxrcpCjW3UnAo
         x/JnKcnM+L9nANJ7fJG7HYhvQWTRfXjiIgVsZDWbZV8Eh4sRb2riB0P99pSwT73dB2SU
         Uh2buSYGye6ilg3Edh+/8vK1fnuQA4iek67Z3IdZzyx9kLT7mejP1ifxpQnBD9xuwrZG
         8pb7q7uLsPu8VxK359mvFOEE2CXYwkqPHJDw5EgfzzqIv/HqiGYVmiTDjb4ObBKxoRZs
         JJ0aEZa4IhV8ZXpRvxuM+BIWYteYMFJbdHpSkZWT3IEZOoyeNaaghqRYWqeZnYTHyJC4
         ujXw==
X-Received: by 10.68.227.97 with SMTP id rz1mr18904950pbc.45.1364245843095;
        Mon, 25 Mar 2013 14:10:43 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id mz8sm14689285pbc.9.2013.03.25.14.10.40
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 25 Mar 2013 14:10:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130325202134.GE16019@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219091>

Jeff King wrote:

> We do not have many tests for handling corrupt objects. This
> new test at least checks that we detect a byte error in a
> corrupt blob object while streaming it out with cat-file.

Thanks.

[...]
> +# convert "1234abcd" to ".git/objects/12/34abcd"
> +obj_to_file() {
> +	echo "$(git rev-parse --git-dir)/objects/$(git rev-parse "$1" | sed 's,..,&/,')"
> +}

Maybe this would be clearer in multiple lines?

	commit=$(git rev-parse --verify "$1") &&
	git_dir=$(git rev-parse --git-dir) &&
	tail=${commit#??} &&
	echo "$git_dir/objects/${commit%$tail}/$tail"

> +
> +# Convert byte at offset "$2" of object "$1" into '\0'
> +corrupt_byte() {
> +	obj_file=$(obj_to_file "$1") &&
> +	chmod +w "$obj_file" &&
> +	printf '\0' | dd of="$obj_file" bs=1 seek="$2"

Some other tests such as t4205 also rely on "printf" being
binary-safe.  Phew.

> +}
> +
> +test_expect_success 'setup corrupt repo' '
> +	git init bit-error &&
> +	(
> +		cd bit-error &&
> +		test_commit content &&
> +		corrupt_byte HEAD:content.t 10
> +	)
> +'
> +
> +test_expect_success 'streaming a corrupt blob fails' '

"fails gracefully", maybe, to be more precise.

With or without the two changes suggested above,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
