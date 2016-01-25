From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v3 0/2] Let merge-file write out conflict markers with correct
 EOLs
Date: Mon, 25 Jan 2016 09:06:59 +0100 (CET)
Message-ID: <cover.1453709205.git.johannes.schindelin@gmx.de>
References: <cover.1453632296.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Beat Bolli <dev+git@drbeat.li>,
	Jeff King <peff@peff.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?ISO-8859-15?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 25 09:07:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNcBI-0000Vo-SP
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jan 2016 09:07:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754014AbcAYIHO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2016 03:07:14 -0500
Received: from mout.gmx.net ([212.227.15.19]:52340 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751913AbcAYIHL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2016 03:07:11 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0LvVYZ-1ZxJeI24G3-010fPL; Mon, 25 Jan 2016 09:07:01
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1453632296.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:2dYiqyCQQtC8d+RTqkUCE9poVXrukh5X1vvrPW0N4xUvcUEKTNY
 kC3rd/OwXyufrSEsuJlKungQFmgDLA1EuMJWc+PfQOO1CbXGXg2Wt4kCnnL1K8haZw13IDB
 bv7LHP4gM0siX7ftT2VWv4RnqEg9hyFWoe93nIeMjl9N8eEuCqMj448P+Bolkcq+2GxDjXy
 wOX68oXOjnrLC96Gg19tw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:tRYod+Fhx2M=:spZBN0pLYSj248x7jd4RDA
 LUdX/M64XhbldJXqCebBQ7kOUq0dZsCYNAu1yW0bJqrYx+3TWspRjFlH4vf8BAXM2jMltUT3d
 I916uRzFE6M+04CzCIUV5UxAwFTNbY2hzLJrgem5iHrQSV2ZVYR+sc+PkxmCIF8Naw1930Kog
 kqwSq9xaWjB+psD3SPWA7K9Kcb5uNPB6mP6aY7O85E8sxzSJAAhQkjiXvB61pD0TkiiI58kcM
 RJvXgz009ncRJ58wIxJpxxAFqBVA/cIbCt+Pju7LfhrCIyGMPQd1lZ7ZB5NRzgHo9HzH3IX8t
 Q2p9R7KqBylZUQZFVrsI50JJl91BFzQylnNEnnubQ/IvHXntGQg7bwYir+lvHvZRmkBJ3q9mx
 tkxKrPUzP0E0VpTCUp+XyzE20Evq1q4ozeOnPpS+KdPt754/ZWZh3iQfD9Qa4hjAhyMp63vny
 on0if8nTX/87f+9Ch0387R7i09t1YfkTtDYeVQ6URUnWZhkoxMmoxCRBDCspSOVYLxraiqsRO
 NRVKhg4p9BNfBalzwJul/fFtgueOs+PQoZs279a3oGq3c0pKQFgSKBPUIrunuo5Dn7jfOfinm
 8CtvdqmYdg7CIlzQKpYHOSJgJ8A3GnTxOcaOQxaSsf4B6llXWlNosuOT9NIF4u6BBrBCJHEab
 D1vAm1Ti9ExjeNn7WUOIpijtFYN6pfWGpZeygXqUUtqWnxsl0Pw2P4Fi6G7ponewRIqcQOT2l
 WLAzISf6pABU83nhiHAE/gxv11kolkXkpEnv/9p/c5GtWk/+pPoFKyiVza37OBWy5WzPH2YE 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284724>

The original patch was sent by Beat Bolli in
http://thread.gmane.org/gmane.comp.version-control.git/281600

My suggestion to extend it to respect gitattributes led to
changes that broke the original patch. And they were misguided
to begin with (see below).

Since there have been a couple of "What's cooking" mails
containing unheard calls for updates on this patch, I took it
on myself to fix things.

Junio's comment that we might look at blobs containing CR/LF
line endings made me rethink the entire approach, and I am now
convinced that we need to abandon the entire idea to make the
conflict markers depend on config settings or attributes:
after all, I introduced `git merge-file` as a replacement for
GNU merge that can be used *outside* of any repository, by design.

The crucial idea hit me yesterday when I took a step back: all
we need to do is to ensure that the end-of-line style is matched
when *all* input files are LF-only, or when they are all CR/LF.
In all other cases, we have mixed line endings anyway.

And to do that, it is sufficient to look at *one single line
ending* in the context. Technically, it does not even have to be
the context, but the first line endings of the first file would
be enough, however it is so much more pleasant if the conflict
marker's eol matches the one of the preceding line.

To prevent my future self from repeating mistakes, I added a
little bit of background to the first commit message.

Triggered by a comment by Junio, I realized that a second patch is
needed: we need to make sure that the conflicting sections are also
augmented by the appropriate line endings if they lack any.

Relative to v2, the first patch changed only in the test code, to
accomodate for the newly-introduced second patch.


Johannes Schindelin (2):
  merge-file: let conflict markers match end-of-line style of the
    context
  merge-file: ensure that conflict sections match eol style

 t/t6023-merge-file.sh | 13 +++++++
 xdiff/xmerge.c        | 98 +++++++++++++++++++++++++++++++++++++++++----------
 2 files changed, 93 insertions(+), 18 deletions(-)

Interdiff vs v2:

 diff --git a/t/t6023-merge-file.sh b/t/t6023-merge-file.sh
 index f0cb9ce..1390548 100755
 --- a/t/t6023-merge-file.sh
 +++ b/t/t6023-merge-file.sh
 @@ -346,13 +346,14 @@ test_expect_success 'conflict at EOF without LF resolved by --union' \
  	 printf "line1\nline2\nline3x\nline3y" >expect.txt &&
  	 test_cmp expect.txt output.txt'
  
 -test_expect_success 'conflict markers match existing line endings' '
 -	append_cr <nolf-orig.txt >crlf-orig.txt &&
 -	append_cr <nolf-diff1.txt >crlf-diff1.txt &&
 -	append_cr <nolf-diff2.txt >crlf-diff2.txt &&
 +test_expect_success 'conflict sections match existing line endings' '
 +	printf "1\\r\\n2\\r\\n3" >crlf-orig.txt &&
 +	printf "1\\r\\n2\\r\\n4" >crlf-diff1.txt &&
 +	printf "1\\r\\n2\\r\\n5" >crlf-diff2.txt &&
  	test_must_fail git -c core.eol=crlf merge-file -p \
  		crlf-diff1.txt crlf-orig.txt crlf-diff2.txt >crlf.txt &&
  	test $(tr "\015" Q <crlf.txt | grep "\\.txtQ$" | wc -l) = 3 &&
 +	test $(tr "\015" Q <crlf.txt | grep "[345]Q$" | wc -l) = 3 &&
  	test_must_fail git -c core.eol=crlf merge-file -p \
  		nolf-diff1.txt nolf-orig.txt nolf-diff2.txt >nolf.txt &&
  	test $(tr "\015" Q <nolf.txt | grep "\\.txtQ$" | wc -l) = 0
 diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
 index c852acc..d98f430 100644
 --- a/xdiff/xmerge.c
 +++ b/xdiff/xmerge.c
 @@ -109,7 +109,7 @@ static int xdl_merge_cmp_lines(xdfenv_t *xe1, int i1, xdfenv_t *xe2, int i2,
  	return 0;
  }
  
 -static int xdl_recs_copy_0(int use_orig, xdfenv_t *xe, int i, int count, int add_nl, char *dest)
 +static int xdl_recs_copy_0(int use_orig, xdfenv_t *xe, int i, int count, int needs_cr, int add_nl, char *dest)
  {
  	xrecord_t **recs;
  	int size = 0;
 @@ -125,6 +125,12 @@ static int xdl_recs_copy_0(int use_orig, xdfenv_t *xe, int i, int count, int add
  	if (add_nl) {
  		i = recs[count - 1]->size;
  		if (i == 0 || recs[count - 1]->ptr[i - 1] != '\n') {
 +			if (needs_cr) {
 +				if (dest)
 +					dest[size] = '\r';
 +				size++;
 +			}
 +
  			if (dest)
  				dest[size] = '\n';
  			size++;
 @@ -133,14 +139,14 @@ static int xdl_recs_copy_0(int use_orig, xdfenv_t *xe, int i, int count, int add
  	return size;
  }
  
 -static int xdl_recs_copy(xdfenv_t *xe, int i, int count, int add_nl, char *dest)
 +static int xdl_recs_copy(xdfenv_t *xe, int i, int count, int needs_cr, int add_nl, char *dest)
  {
 -	return xdl_recs_copy_0(0, xe, i, count, add_nl, dest);
 +	return xdl_recs_copy_0(0, xe, i, count, needs_cr, add_nl, dest);
  }
  
 -static int xdl_orig_copy(xdfenv_t *xe, int i, int count, int add_nl, char *dest)
 +static int xdl_orig_copy(xdfenv_t *xe, int i, int count, int needs_cr, int add_nl, char *dest)
  {
 -	return xdl_recs_copy_0(1, xe, i, count, add_nl, dest);
 +	return xdl_recs_copy_0(1, xe, i, count, needs_cr, add_nl, dest);
  }
  
  /*
 @@ -172,15 +178,8 @@ static int is_eol_crlf(xdfile_t *file, int i)
  		file->recs[i - 1]->ptr[size - 2] == '\r';
  }
  
 -static int fill_conflict_hunk(xdfenv_t *xe1, const char *name1,
 -			      xdfenv_t *xe2, const char *name2,
 -			      const char *name3,
 -			      int size, int i, int style,
 -			      xdmerge_t *m, char *dest, int marker_size)
 +static int is_cr_needed(xdfenv_t *xe1, xdfenv_t *xe2, xdmerge_t *m)
  {
 -	int marker1_size = (name1 ? strlen(name1) + 1 : 0);
 -	int marker2_size = (name2 ? strlen(name2) + 1 : 0);
 -	int marker3_size = (name3 ? strlen(name3) + 1 : 0);
  	int needs_cr;
  
  	/* Match post-images' preceding, or first, lines' end-of-line style */
 @@ -191,14 +190,25 @@ static int fill_conflict_hunk(xdfenv_t *xe1, const char *name1,
  	if (needs_cr)
  		needs_cr = is_eol_crlf(&xe1->xdf1, 0);
  	/* If still undecided, use LF-only */
 -	if (needs_cr < 0)
 -		needs_cr = 0;
 +	return needs_cr < 0 ? 0 : needs_cr;
 +}
 +
 +static int fill_conflict_hunk(xdfenv_t *xe1, const char *name1,
 +			      xdfenv_t *xe2, const char *name2,
 +			      const char *name3,
 +			      int size, int i, int style,
 +			      xdmerge_t *m, char *dest, int marker_size)
 +{
 +	int marker1_size = (name1 ? strlen(name1) + 1 : 0);
 +	int marker2_size = (name2 ? strlen(name2) + 1 : 0);
 +	int marker3_size = (name3 ? strlen(name3) + 1 : 0);
 +	int needs_cr = is_cr_needed(xe1, xe2, m);
  
  	if (marker_size <= 0)
  		marker_size = DEFAULT_CONFLICT_MARKER_SIZE;
  
  	/* Before conflicting part */
 -	size += xdl_recs_copy(xe1, i, m->i1 - i, 0,
 +	size += xdl_recs_copy(xe1, i, m->i1 - i, 0, 0,
  			      dest ? dest + size : NULL);
  
  	if (!dest) {
 @@ -217,7 +227,7 @@ static int fill_conflict_hunk(xdfenv_t *xe1, const char *name1,
  	}
  
  	/* Postimage from side #1 */
 -	size += xdl_recs_copy(xe1, m->i1, m->chg1, 1,
 +	size += xdl_recs_copy(xe1, m->i1, m->chg1, needs_cr, 1,
  			      dest ? dest + size : NULL);
  
  	if (style == XDL_MERGE_DIFF3) {
 @@ -236,7 +246,7 @@ static int fill_conflict_hunk(xdfenv_t *xe1, const char *name1,
  				dest[size++] = '\r';
  			dest[size++] = '\n';
  		}
 -		size += xdl_orig_copy(xe1, m->i0, m->chg0, 1,
 +		size += xdl_orig_copy(xe1, m->i0, m->chg0, needs_cr, 1,
  				      dest ? dest + size : NULL);
  	}
  
 @@ -251,7 +261,7 @@ static int fill_conflict_hunk(xdfenv_t *xe1, const char *name1,
  	}
  
  	/* Postimage from side #2 */
 -	size += xdl_recs_copy(xe2, m->i2, m->chg2, 1,
 +	size += xdl_recs_copy(xe2, m->i2, m->chg2, needs_cr, 1,
  			      dest ? dest + size : NULL);
  	if (!dest) {
  		size += marker_size + 1 + needs_cr + marker2_size;
 @@ -290,21 +300,24 @@ static int xdl_fill_merge_buffer(xdfenv_t *xe1, const char *name1,
  						  marker_size);
  		else if (m->mode & 3) {
  			/* Before conflicting part */
 -			size += xdl_recs_copy(xe1, i, m->i1 - i, 0,
 +			size += xdl_recs_copy(xe1, i, m->i1 - i, 0, 0,
  					      dest ? dest + size : NULL);
  			/* Postimage from side #1 */
 -			if (m->mode & 1)
 -				size += xdl_recs_copy(xe1, m->i1, m->chg1, (m->mode & 2),
 +			if (m->mode & 1) {
 +				int needs_cr = is_cr_needed(xe1, xe2, m);
 +
 +				size += xdl_recs_copy(xe1, m->i1, m->chg1, needs_cr, (m->mode & 2),
  						      dest ? dest + size : NULL);
 +			}
  			/* Postimage from side #2 */
  			if (m->mode & 2)
 -				size += xdl_recs_copy(xe2, m->i2, m->chg2, 0,
 +				size += xdl_recs_copy(xe2, m->i2, m->chg2, 0, 0,
  						      dest ? dest + size : NULL);
  		} else
  			continue;
  		i = m->i1 + m->chg1;
  	}
 -	size += xdl_recs_copy(xe1, i, xe1->xdf2.nrec - i, 0,
 +	size += xdl_recs_copy(xe1, i, xe1->xdf2.nrec - i, 0, 0,
  			      dest ? dest + size : NULL);
  	return size;
  }

-- 
2.7.0.windows.1.7.g55a05c8
