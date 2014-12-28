From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 5/5] checkout-index: fix --temp relative path mangling
Date: Sat, 27 Dec 2014 22:19:48 -0500
Message-ID: <CAPig+cTCQgdX0FgZCiL921bAycEoceeKXT5UpnD7_Ro=NJH0Yg@mail.gmail.com>
References: <1419414196-58587-1-git-send-email-sunshine@sunshineco.com>
	<1419414196-58587-6-git-send-email-sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	"Shawn O . Pearce" <spearce@spearce.org>
To: Git List <git@vger.kernel.org>, Russ Cox <rsc@golang.org>
X-From: git-owner@vger.kernel.org Sun Dec 28 04:20:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y54Ov-0002QN-K6
	for gcvg-git-2@plane.gmane.org; Sun, 28 Dec 2014 04:20:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751542AbaL1DTt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Dec 2014 22:19:49 -0500
Received: from mail-yk0-f177.google.com ([209.85.160.177]:58900 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751425AbaL1DTs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Dec 2014 22:19:48 -0500
Received: by mail-yk0-f177.google.com with SMTP id 9so5803928ykp.36
        for <git@vger.kernel.org>; Sat, 27 Dec 2014 19:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=7I4wZTXcaEnNaIep5fuF4V1OErkiA/RGsYxYcJd2Fv4=;
        b=hos+mLIEHZFUHfmzV0+/CtE1/fJ5mvA8JbOmr3iW0Sn2yUXtI4d1v6FvpGcFDwxdDS
         gqHAjMHk4UAFnImKfP7IjgGTJpxI0p0slZQoCjd1lyuhvM+k+wmiNrh+ueGTOfuFZkUc
         yloDDIwLkgGueQa0N9OSFsXKjPRTe3uiVyrJMDCFpacaK9IohShzkjt72Axjdmvm6CNl
         P5USr6ezmzmVq97Jy1Db+SOa+1tiZPZBBUUW2E4kfkKa81hpZlQ75/4p4u555DyvWGX1
         m0WdlLKsYNjlxwC7Tt35QJs/aRZqVCpd6zZ3cnWEikJ2rNb+zkqrn3x0xGEtYpSfyJnc
         I2UQ==
X-Received: by 10.170.119.7 with SMTP id l7mr9355522ykb.51.1419736788233; Sat,
 27 Dec 2014 19:19:48 -0800 (PST)
Received: by 10.170.73.7 with HTTP; Sat, 27 Dec 2014 19:19:48 -0800 (PST)
In-Reply-To: <1419414196-58587-6-git-send-email-sunshine@sunshineco.com>
X-Google-Sender-Auth: ttoH_cUGBB9Ni4aR2nPlS_PuhKI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261853>

On Wed, Dec 24, 2014 at 4:43 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> checkout-index --temp only properly prints relative paths which are
> descendants of the current directory. Paths in ancestor or sibling
> directories (or their children) are often printed in mangled form. For
> example:
>
>     mkdir a bbb &&
>     >file &&
>     >bbb/file &&
>     git update-index --add file bbb/file &&
>     cd a &&
>     git checkout-index --temp ../file ../bbb/file
>
> prints:
>
>     .merge_file_ooblek  le
>     .merge_file_igloo0  b/file
>
> rather than the correct:
>
>     .merge_file_ooblek  ../file
>     .merge_file_igloo0  ../bbb/file
>
> Internally, given the above example, checkout-index prefixes each input
> argument with the name of the current directory ("a/", in this case),
> and then assumes that it can simply skip forward by strlen("a/") bytes
> to recover the original name. This works for files in the current
> directory or its descendants, but fails for files in ancestors or
> siblings (or their children) due to path normalization.
>
> For instance, given "../file", "a/" is appended, giving "a/../file".

s/appended/prepended/

> Path normalization folds out "a/../", resulting in "file". Attempting
> to recover the original name by skipping strlen("a/") bytes gives the
> incorrect "le" rather than the desired "../file".
>
> Fix this by taking advantage of write_name_quoted_relative() to recover
> the original name properly, rather than assuming that it can be
> recovered by skipping strlen(prefix) bytes.
>
> As a bonus, this also fixes a bug in which checkout-index --temp
> accessed and printed memory beyond the end-of-string. For instance,
> within a subdirectory named "subdirectory", and given argument
> "../file", prefixing would give "subdirectory/../file", which would
> become "file" after normalization. checkout-index would then attempt to
> recover the original name by skipping strlen("subdirectory/") bytes of
> "file", which placed it well beyond end-of-string. Despite this error,
> it often appeared to give the correct result, but only due to an
> accident of implementation which left an apparently correct copy of the
> path in memory following the normalized value. In particular, handed
> "subdirectory/../file", in-place processing by normalize_path_copy_len()
> resulted in "file\0rectory/../file". When checkout-index skipped
> strlen("subdirectory/") bytes, it ended up back at "../file" and thus
> appeared to give the correct answer, despite being past end-of-string.
>
> Reported-by: Russ Cox <rsc@golang.org>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
