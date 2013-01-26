From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH 2/2] git-p4.py: support Python 2.4
Date: Sat, 26 Jan 2013 07:48:54 -0500
Message-ID: <20130126124854.GB31052@padd.com>
References: <1359146641-27810-1-git-send-email-drafnel@gmail.com>
 <1359146641-27810-3-git-send-email-drafnel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, esr@thyrsus.com, john@keeping.me.uk,
	Brandon Casey <bcasey@nvidia.com>
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 26 13:49:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tz5CA-0004bd-O2
	for gcvg-git-2@plane.gmane.org; Sat, 26 Jan 2013 13:49:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753838Ab3AZMs6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jan 2013 07:48:58 -0500
Received: from honk.padd.com ([74.3.171.149]:59239 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753630Ab3AZMs5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jan 2013 07:48:57 -0500
Received: from arf.padd.com (unknown [50.52.174.88])
	by honk.padd.com (Postfix) with ESMTPSA id 7FBDF2F3F;
	Sat, 26 Jan 2013 04:48:56 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 5BF682262D; Sat, 26 Jan 2013 07:48:54 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <1359146641-27810-3-git-send-email-drafnel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214623>

drafnel@gmail.com wrote on Fri, 25 Jan 2013 12:44 -0800:
> Python 2.4 lacks the following features:
> 
>    subprocess.check_call
>    struct.pack_into
> 
> Take a cue from 460d1026 and provide an implementation of the
> CalledProcessError exception.  Then replace the calls to
> subproccess.check_call with calls to subprocess.call that check the return
> status and raise a CalledProcessError exception if necessary.
> 
> The struct.pack_into in t/9802 can be converted into a single struct.pack
> call which is available in Python 2.4.

Excellent.  Should have used struct.pack() from the get-go.

Acked-by: Pete Wyckoff <pw@padd.com>

> diff --git a/t/t9802-git-p4-filetype.sh b/t/t9802-git-p4-filetype.sh
> index 21924df..be299dc 100755
> --- a/t/t9802-git-p4-filetype.sh
> +++ b/t/t9802-git-p4-filetype.sh
> @@ -105,12 +105,13 @@ build_gendouble() {
>  	cat >gendouble.py <<-\EOF
>  	import sys
>  	import struct
> -	import array
>  
> -	s = array.array("c", '\0' * 26)
> -	struct.pack_into(">L", s,  0, 0x00051607)  # AppleDouble
> -	struct.pack_into(">L", s,  4, 0x00020000)  # version 2
> -	s.tofile(sys.stdout)
> +	s = struct.pack(">LL18s",
> +			0x00051607,  # AppleDouble
> +			0x00020000,  # version 2
> +			""           # pad to 26 bytes
> +	)
> +	sys.stdout.write(s);
>  	EOF

One stray semicolon.

In terms of maintenance, I'll not run tests with 2.4 or 2.5
myself, but maybe you would be willing to check an RC candidate
each release?

		-- Pete
