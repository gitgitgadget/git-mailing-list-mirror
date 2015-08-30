From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v4 2/4] path: optimize common dir checking
Date: Sun, 30 Aug 2015 08:25:03 +0200
Message-ID: <55E2A1BF.5080204@web.de>
References: <1440618365-20628-1-git-send-email-dturner@twopensource.com>
 <1440618365-20628-3-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: David Turner <dturner@twopensource.com>, git@vger.kernel.org,
	mhagger@alum.mit.edu, pclouds@gmail.com, sunshine@sunshineco.com
X-From: git-owner@vger.kernel.org Sun Aug 30 08:25:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZVw3N-0003ac-VW
	for gcvg-git-2@plane.gmane.org; Sun, 30 Aug 2015 08:25:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751092AbbH3GZO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Aug 2015 02:25:14 -0400
Received: from mout.web.de ([212.227.15.3]:56423 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750953AbbH3GZM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Aug 2015 02:25:12 -0400
Received: from birne.local ([213.66.56.100]) by smtp.web.de (mrweb001) with
 ESMTPSA (Nemesis) id 0Lilcj-1Z0BbR2ZKv-00cyEy; Sun, 30 Aug 2015 08:25:04
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:38.0)
 Gecko/20100101 Thunderbird/38.2.0
In-Reply-To: <1440618365-20628-3-git-send-email-dturner@twopensource.com>
X-Provags-ID: V03:K0:R9coejJK2c2SMUbyp3JvCl0z4zjX2SSaJ+P5IRWl8dIjQl+mjkn
 XtTTJU+Eth20UNMb1DYk/OpcEHOw814SUtJ6/YJDDovHwVH3cAwkoIhYWLjarridjMiiKMj
 OBA8NcGn0aaBcOWjmypRJjW0yrciPhwU5ptJipmDrYaygA3dbX2KtPJQCYmq8bBtfHRBC05
 yY6debnC13o16GmluuGug==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Sj8cuyzsdjA=:tlXv+mBzKb7DRSvDoVmVkz
 rEvh4axeFIqiunyxQgbHxfhZk1wyio0kCxIpkO/K2bB6/CU0z9rnFNixpUtXIWGlPk4VlxTGa
 OnVDKp4LXMoEr8t2PdBDblttVDlyek3rFUT85YaOb+/vshTJX8/9AOW+QgdyWetprQGJloSji
 H0l04SFTz02a4UjXl8bUtvV1JS58UA+G9q+F05qr865LKRqSdDhXONlpD1o15pivLxpooihoy
 ry2/Fdz0w5TZ+IAOEUluL0lmcNpMnDGij6RqzfrBHcas1mN0EJ27p8ardZ3bASCcJ24nx+aKn
 ey/tSUG3VTGfGkCUaDt3Gjgo7nGbGs7H7PFpikDIatSM+xFmQxLCR/dBVPQ3hYyQFCS+nRdtc
 XelCDsMc8c7b0kCoS/biJNzKKVwvXhLRcEO0Qjin3rXCZPJfU6fmBujIdqDj3YFHDf0ObXRhK
 iR/Wd3xmfCqXqw4tgOJOtUwpx1Qbu2g6aUxGL8/r2gsinOIdprQi1jBVkzeZ5O/zgZfvH4e44
 BYNP12EECGpyKZgJFwEV+AswM3AFf82f1X9vPns9BCyH+HddscU6eZ84HY/F/UaAKwRpyJn57
 keDHDlyFKYTaUxBCIptPvrv5had9+Lax6gT71zD0Cg3ymaCEJ/UpKt02PMIOpbLT1hQHrGyd/
 AA1tzmieW/a4r4keUXelyDKjR9T+1wuS3EiGXiypP3HBVcaX1JoYLw6eyDsEPZLTcDi1kM3TM
 LxlxDcWoLjMqjPO/gKf/rGyiOWR3REd2VD11NA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276802>

On 26.08.15 21:46, David Turner wrote:
> Instead of a linear search over common_list to check whether
> a path is common, use a trie.  The trie search operates on
> path prefixes, and handles excludes.
> 
> Signed-off-by: David Turner <dturner@twopensource.com>
> ---
>  path.c                | 226 ++++++++++++++++++++++++++++++++++++++++++++++----
>  t/t0060-path-utils.sh |   1 +
>  2 files changed, 213 insertions(+), 14 deletions(-)
> 
> diff --git a/path.c b/path.c


> +		child->len = root->len - i - 1;
> +		if (child->len) {
> +			child->contents = strndup(root->contents + i + 1,
> +						   child->len);
>  		}
Could we use xtrndup() instead of strndup() ?
(Otherwise it won't compile under Mac OS here)
