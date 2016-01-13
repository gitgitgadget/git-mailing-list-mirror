From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v4 4/4] t0060: verify that basename() and dirname() work
 as expected
Date: Wed, 13 Jan 2016 00:58:26 +0000
Message-ID: <5695A132.1040100@ramsayjones.plus.com>
References: <cover.1452536924.git.johannes.schindelin@gmx.de>
 <cover.1452585382.git.johannes.schindelin@gmx.de>
 <7d73267984ab029df022477e341c536e111eafdd.1452585382.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 01:58:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJ9lj-0004Cx-1G
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 01:58:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754275AbcAMA6b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2016 19:58:31 -0500
Received: from avasout04.plus.net ([212.159.14.19]:57639 "EHLO
	avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752575AbcAMA6b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2016 19:58:31 -0500
Received: from [10.0.2.15] ([46.208.159.221])
	by avasout04 with smtp
	id 5CyU1s0054mu3xa01CyVVY; Wed, 13 Jan 2016 00:58:30 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=CvRCCSMD c=1 sm=1 tr=0
 a=Sp5fw55EgyGSOjouSGNDoQ==:117 a=Sp5fw55EgyGSOjouSGNDoQ==:17 a=0Bzu9jTXAAAA:8
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=EBOSESyhAAAA:8
 a=N659UExz7-8A:10 a=qeXacbCnsdSkGGAaSj4A:9 a=pILNOxqGKmIA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.4.0
In-Reply-To: <7d73267984ab029df022477e341c536e111eafdd.1452585382.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283866>



On 12/01/16 07:57, Johannes Schindelin wrote:
> Unfortunately, some libgen implementations yield outcomes different
> from what Git expects. For example, mingw-w64-crt provides a basename()
> function, that shortens `path0/` to `path`!
> 
> So let's verify that the basename() and dirname() functions we use
> conform to what Git expects.
> 
> Derived-from-code-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  t/t0060-path-utils.sh |   3 +
>  test-path-utils.c     | 166 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 169 insertions(+)
> 
> diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
> index 627ef85..f0152a7 100755
> --- a/t/t0060-path-utils.sh
> +++ b/t/t0060-path-utils.sh
> @@ -59,6 +59,9 @@ case $(uname -s) in
>  	;;
>  esac
>  
> +test_expect_success basename 'test-path-utils basename'
> +test_expect_success dirname 'test-path-utils dirname'
> +
>  norm_path "" ""
>  norm_path . ""
>  norm_path ./ ""
> diff --git a/test-path-utils.c b/test-path-utils.c
> index c67bf65..4ab68ac 100644
> --- a/test-path-utils.c
> +++ b/test-path-utils.c
> @@ -39,6 +39,166 @@ static void normalize_argv_string(const char **var, const char *input)
>  		die("Bad value: %s\n", input);
>  }
>  
> +struct test_data {
> +	const char *from;  /* input:  transform from this ... */
> +	const char *to;    /* output: ... to this.            */
> +};
> +
> +static int test_function(struct test_data *data, char *(*func)(char *input),
> +	const char *funcname)
> +{
> +	int failed = 0, i;
> +	char buffer[1024];
> +	char *to;
> +
> +	for (i = 0; data[i].to; i++) {
> +		if (!data[i].from)
> +			to = func(NULL);
> +		else {
> +			strcpy(buffer, data[i].from);
> +			to = func(buffer);
> +		}
> +		if (strcmp(to, data[i].to)) {
> +			error("FAIL: %s(%s) => '%s' != '%s'\n",
> +				funcname, data[i].from, to, data[i].to);
> +			failed = 1;
> +		}
> +	}
> +	return failed;
> +}
> +
> +static struct test_data basename_data[] = {
> +	/* --- POSIX type paths --- */
> +	{ NULL,              "."    },
> +	{ "",                "."    },
> +	{ ".",               "."    },
> +	{ "..",              ".."   },
> +	{ "/",               "/"    },
> +#if defined(__CYGWIN__) && !defined(NO_LIBGEN_H)
> +	{ "//",              "//"   },
> +	{ "///",             "//"   },
> +	{ "////",            "//"   },
> +#else
> +	{ "//",              "/"    },
> +	{ "///",             "/"    },
> +	{ "////",            "/"    },
> +#endif
> +	{ "usr",             "usr"  },
> +	{ "/usr",            "usr"  },
> +	{ "/usr/",           "usr"  },
> +	{ "/usr//",          "usr"  },
> +	{ "/usr/lib",        "lib"  },
> +	{ "usr/lib",         "lib"  },
> +	{ "usr/lib///",      "lib"  },
> +
> +#if defined(__MINGW32__) || defined(_MSC_VER)
> +
> +	/* --- win32 type paths --- */
> +	{ "\\usr",           "usr"  },
> +	{ "\\usr\\",         "usr"  },
> +	{ "\\usr\\\\",       "usr"  },
> +	{ "\\usr\\lib",      "lib"  },
> +	{ "usr\\lib",        "lib"  },
> +	{ "usr\\lib\\\\\\",  "lib"  },
> +	{ "C:/usr",          "usr"  },
> +	{ "C:/usr",          "usr"  },

This duplication was in the test-libgen.c file I sent
you ... so, my bad. ;-)

Did you not have more tests to add?

ATB,
Ramsay Jones
