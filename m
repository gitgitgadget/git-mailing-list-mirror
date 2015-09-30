From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH] Provide a dirname() function when NO_LIBGEN_H=YesPlease
Date: Wed, 30 Sep 2015 19:57:53 +0100
Message-ID: <560C30B1.3010508@ramsayjones.plus.com>
References: <25a2598e756959f55f06ae6b4dc6f448e3b6b127.1443624188.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090600030904030801080104"
Cc: git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 30 20:58:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZhMZo-0003Nf-IS
	for gcvg-git-2@plane.gmane.org; Wed, 30 Sep 2015 20:58:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933179AbbI3S57 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Sep 2015 14:57:59 -0400
Received: from avasout08.plus.net ([212.159.14.20]:56633 "EHLO
	avasout08.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932871AbbI3S56 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Sep 2015 14:57:58 -0400
Received: from [10.0.2.15] ([81.174.177.104])
	by avasout08 with smtp
	id PWxt1r0022FXpih01Wxwxl; Wed, 30 Sep 2015 19:57:56 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=bI7rW6KZ c=1 sm=1 tr=0
 a=IMS4QkGEsjO3VZZSAZDX8w==:117 a=IMS4QkGEsjO3VZZSAZDX8w==:17 a=0Bzu9jTXAAAA:8
 a=EBOSESyhAAAA:8 a=r77TgQKjGQsHNAKrUKIA:9 a=86316OMWksOd81l1pRMA:9
 a=pILNOxqGKmIA:10 a=MbS5fQb5ABhTcgSWyuoA:9
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
In-Reply-To: <25a2598e756959f55f06ae6b4dc6f448e3b6b127.1443624188.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278855>

This is a multi-part message in MIME format.
--------------090600030904030801080104
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit

Hi Johannes,

On 30/09/15 15:50, Johannes Schindelin wrote:
> When there is no `libgen.h` to our disposal, we miss the `dirname()`
> function.
> 
> So far, we only had one user of that function: credential-cache--daemon
> (which was only compiled when Unix sockets are available, anyway). But
> now we also have `builtin/am.c` as user, so we need it.

Yes, many moons ago (on my old 32-bit laptop) when I was still 'working'
with MinGW I noticed this same thing while looking into providing a win32
emulation of unix sockets. So, I had to look into this at the same time.
Since this didn't progress, I didn't mention the libgen issue.

Anyway, I still have a 'test-libgen.c' file (attached) from back then that
contains some tests. I don't quite recall what the final state of this
code was, but it was intended to test _existing_ libgen implementations
as well as provide a 'git' version which would work on MinGW, cygwin and
linux. Note that some of the existing implementations didn't all agree on
what the tests should report! I don't remember if I looked at the POSIX
spec or not.

So, I don't know how useful it will be - if nothing else, there are some
tests! :-D

HTH

Ramsay Jones


> 
> Since `dirname()` is a sibling of `basename()`, we simply put our very
> own `gitdirname()` implementation next to `gitbasename()` and use it
> if `NO_LIBGEN_H` has been set.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> 
> 	I stumbled over the compile warning when upgrading Git for Windows
> 	to 2.6.0. There was a left-over NO_LIBGEN_H=YesPlease (which we
> 	no longer need in Git for Windows 2.x), but it did point to the
> 	fact that we use `dirname()` in builtin/am.c now, so we better
> 	have a fall-back implementation for platforms without libgen.h.
> 
> 	I tested this implementation a bit, but I still would appreciate
> 	a few eye-balls to go over it.
> 
>  compat/basename.c | 26 ++++++++++++++++++++++++++
>  git-compat-util.h |  2 ++
>  2 files changed, 28 insertions(+)
> 
> diff --git a/compat/basename.c b/compat/basename.c
> index d8f8a3c..10dba38 100644
> --- a/compat/basename.c
> +++ b/compat/basename.c
> @@ -13,3 +13,29 @@ char *gitbasename (char *path)
>  	}
>  	return (char *)base;
>  }
> +
> +char *gitdirname(char *path)
> +{
> +	char *p = path, *slash, c;
> +
> +	/* Skip over the disk name in MSDOS pathnames. */
> +	if (has_dos_drive_prefix(p))
> +		p += 2;
> +	/* POSIX.1-2001 says dirname("/") should return "/" */
> +	slash = is_dir_sep(*p) ? ++p : NULL;
> +	while ((c = *(p++)))
> +		if (is_dir_sep(c)) {
> +			char *tentative = p - 1;
> +
> +			/* POSIX.1-2001 says to ignore trailing slashes */
> +			while (is_dir_sep(*p))
> +				p++;
> +			if (*p)
> +				slash = tentative;
> +		}
> +
> +	if (!slash)
> +		return ".";
> +	*slash = '\0';
> +	return path;
> +}
> diff --git a/git-compat-util.h b/git-compat-util.h
> index f649e81..8b01aa5 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -253,6 +253,8 @@ struct itimerval {
>  #else
>  #define basename gitbasename
>  extern char *gitbasename(char *);
> +#define dirname gitdirname
> +extern char *gitdirname(char *);
>  #endif
>  
>  #ifndef NO_ICONV
> 

--------------090600030904030801080104
Content-Type: text/x-csrc;
 name="test-libgen.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="test-libgen.c"

#include <stdio.h>
#include <string.h>
#include <ctype.h>
#ifndef NO_LIBGEN_H
# include <libgen.h>
#endif

struct test_data {
	char *from;  /* input:  transform from this ... */
	char *to;    /* output: ... to this.            */
};

#ifdef NO_LIBGEN_H

#if defined(__MINGW32__) || defined(_MSC_VER)
#define has_dos_drive_prefix(path) (isalpha(*(path)) && (path)[1] == ':')
#define is_dir_sep(c) ((c) == '/' || (c) == '\\')
#else
#define has_dos_drive_prefix(path) 0
#define is_dir_sep(c) ((c) == '/')
#endif

#define basename gitbasename
#define dirname gitdirname

char *gitbasename (char *path)
{
	char *p;

	if (!path || !*path)
		return ".";
	/* skip drive designator, if any */
	if (has_dos_drive_prefix(path))
		path += 2;
	if (!*path)
		return ".";
	/* trim trailing directory separators */
	p = path + strlen(path) - 1;
	while (is_dir_sep(*p)) {
		if (p == path)
			return path;
		*p-- = '\0';
	}
	/* find begining of last path component */
	while (p >= path && !is_dir_sep(*p))
		p--;
	return p + 1;
}

char *gitdirname(char *path)
{
	char *p, *start;

	if (!path || !*path)
		return ".";
	start = path;
	/* skip drive designator, if any */
	if (has_dos_drive_prefix(path))
		start += 2;
	/* check for // */
	if (strcmp(start, "//") == 0)
		return path;
	/* check for \\ */
	if (is_dir_sep('\\') && strcmp(start, "\\\\") == 0)
		return path;
	/* trim trailing directory separators */
	p = path + strlen(path) - 1;
	while (is_dir_sep(*p)) {
		if (p == start)
			return path;
		*p-- = '\0';
	}
	/* find begining of last path component */
	while (p >= start && !is_dir_sep(*p))
		p--;
	/* terminate dirname */
	if (p < start) {
		p = start;
		*p++ = '.';
	} else if (p == start)
		p++;
	*p = '\0';
	return path;
}

#endif

static int test_basename(void)
{
	static struct test_data t[] = {

		/* --- POSIX type paths --- */
		{ NULL,              "."    },
		{ "",                "."    },
		{ ".",               "."    },
		{ "..",              ".."   },
		{ "/",               "/"    },
#if defined(__CYGWIN__) && !defined(NO_LIBGEN_H)
		{ "//",              "//"   },
		{ "///",             "//"   },
		{ "////",            "//"   },
#else
		{ "//",              "/"    },
		{ "///",             "/"    },
		{ "////",            "/"    },
#endif
		{ "usr",             "usr"  },
		{ "/usr",            "usr"  },
		{ "/usr/",           "usr"  },
		{ "/usr//",          "usr"  },
		{ "/usr/lib",        "lib"  },
		{ "usr/lib",         "lib"  },
		{ "usr/lib///",      "lib"  },

#if defined(__MINGW32__) || defined(_MSC_VER)

		/* --- win32 type paths --- */
		{ "\\usr",           "usr"  },
		{ "\\usr\\",         "usr"  },
		{ "\\usr\\\\",       "usr"  },
		{ "\\usr\\lib",      "lib"  },
		{ "usr\\lib",        "lib"  },
		{ "usr\\lib\\\\\\",  "lib"  },
		{ "C:/usr",          "usr"  },
		{ "C:/usr",          "usr"  },
		{ "C:/usr/",         "usr"  },
		{ "C:/usr//",        "usr"  },
		{ "C:/usr/lib",      "lib"  },
		{ "C:usr/lib",       "lib"  },
		{ "C:usr/lib///",    "lib"  },
		{ "C:",              "."    },
		{ "C:a",             "a"    },
		{ "C:/",             "/"    },
		{ "C:///",           "/"    },
#if defined(NO_LIBGEN_H)
		{ "\\",              "\\"   },
		{ "\\\\",            "\\"   },
		{ "\\\\\\",          "\\"   },
#else

		/* win32 platform variations: */
#if defined(__MINGW32__)
		{ "\\",              "/"    },
		{ "\\\\",            "/"    },
		{ "\\\\\\",          "/"    },
#endif

#if defined(_MSC_VER)
		{ "\\",              "\\"   },
		{ "\\\\",            "\\"   },
		{ "\\\\\\",          "\\"   },
#endif

#endif
#endif
		{ NULL,              "."    }
	};
	static char input[1024];
	char *from, *to;
	int i, failed = 0;

	for (i = 0; i < sizeof(t)/sizeof(t[0]); i++) {
		from = NULL;
		if (t[i].from) {
			strcpy(input, t[i].from);
			from = input;
		}
		to = basename(from);
		if (strcmp(to, t[i].to) != 0) {
			fprintf(stderr, "FAIL: basename(%s) => '%s' != '%s'\n",
				t[i].from, to, t[i].to);
			failed++;
		}
	}
	return failed != 0;
}

static int test_dirname(void)
{
	static struct test_data t[] = {

		/* --- POSIX type paths --- */
		{ NULL,              "."      },
		{ "",                "."      },
		{ ".",               "."      },
		{ "..",              "."      },
		{ "/",               "/"      },
		{ "//",              "//"     },
#if defined(__CYGWIN__) && !defined(NO_LIBGEN_H)
		{ "///",             "//"     },
		{ "////",            "//"     },
#else
		{ "///",             "/"      },
		{ "////",            "/"      },
#endif
		{ "usr",             "."      },
		{ "/usr",            "/"      },
		{ "/usr/",           "/"      },
		{ "/usr//",          "/"      },
		{ "/usr/lib",        "/usr"   },
		{ "usr/lib",         "usr"    },
		{ "usr/lib///",      "usr"    },

#if defined(__MINGW32__) || defined(_MSC_VER)

		/* --- win32 type paths --- */
		{ "\\",              "\\"     },
		{ "\\\\",            "\\\\"   },
		{ "\\usr",           "\\"     },
		{ "\\usr\\",         "\\"     },
		{ "\\usr\\\\",       "\\"     },
		{ "\\usr\\lib",      "\\usr"  },
		{ "usr\\lib",        "usr"    },
		{ "usr\\lib\\\\\\",  "usr"    },
		{ "C:a",             "C:."    },
		{ "C:/",             "C:/"    },
		{ "C:///",           "C:/"    },
		{ "C:/usr",          "C:/"    },
		{ "C:/usr/",         "C:/"    },
		{ "C:/usr//",        "C:/"    },
		{ "C:/usr/lib",      "C:/usr" },
		{ "C:usr/lib",       "C:usr"  },
		{ "C:usr/lib///",    "C:usr"  },
		{ "\\\\\\",          "\\"     },
		{ "\\\\\\\\",        "\\"     },
#if defined(NO_LIBGEN_H)
		{ "C:",              "C:."    },
#else

		/* win32 platform variations: */
#if defined(__MINGW32__)
		/* the following is clearly wrong ... */
		{ "C:",              "."      },
#endif

#if defined(_MSC_VER)
		{ "C:",              "C:."    },
#endif

#endif
#endif
		{ NULL,              "."      }
	};
	static char input[1024];
	char *from, *to;
	int i, failed = 0;

	for (i = 0; i < sizeof(t)/sizeof(t[0]); i++) {
		from = NULL;
		if (t[i].from) {
			strcpy(input, t[i].from);
			from = input;
		}
		to = dirname(from);
		if (strcmp(to, t[i].to) != 0) {
			fprintf(stderr, "FAIL: dirname(%s) => '%s' != '%s'\n",
				t[i].from, to, t[i].to);
			failed++;
		}
	}
	return failed != 0;
}

int main(int argc, char **argv)
{
	if (argc == 2 && !strcmp(argv[1], "basename"))
		return test_basename();

	if (argc == 2 && !strcmp(argv[1], "dirname"))
		return test_dirname();

	fprintf(stderr, "%s: unknown function name: %s\n", argv[0],
		argv[1] ? argv[1] : "(there was none)");
	return 1;
}

--------------090600030904030801080104--
