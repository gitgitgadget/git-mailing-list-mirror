From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v4 20/21] refs: add LMDB refs storage backend
Date: Sun, 14 Feb 2016 19:04:16 +0700
Message-ID: <CACsJy8CWS9E0Jb4omm4k0=kZ73w9UoHmofLFCFHUhHu53zfgYw@mail.gmail.com>
References: <1454701462-3817-1-git-send-email-dturner@twopensource.com> <1454701462-3817-21-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Sun Feb 14 13:05:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUvQm-0000ST-7x
	for gcvg-git-2@plane.gmane.org; Sun, 14 Feb 2016 13:05:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751491AbcBNMEs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Feb 2016 07:04:48 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:33677 "EHLO
	mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751414AbcBNMEr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Feb 2016 07:04:47 -0500
Received: by mail-lf0-f68.google.com with SMTP id e36so6156339lfi.0
        for <git@vger.kernel.org>; Sun, 14 Feb 2016 04:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=T+Oh1/B6hbL2ZKYAG1mQE+fKQr5P0O22f49MMo1Rn50=;
        b=DPeOtGVDOe+XzU1MTLrkndP9ZYqRv2+d4YNNky72W3dL5uJ85z9ZJlAiosEf50yRPE
         AvgwjdRL6FxVTHHyM0SVogNZKvFPBBdw15pM6gXclAPojaATG2hv1C+a+xk90C4lrxRt
         iQTZp4FwV1rTqVnwGrfJbcE+Lu77I1YReEAtXNDn9ijF86519HALMeCom8jTilne6Xur
         Jf4/1FEs2m+uLFVl668A4MULxNfzVc0JKi1GRnQdCB/xIdPr2TWYwdrKebqv60Qunk/Y
         OJZ573zidBzEniOY1cWUVgSm35ffsw5UcYamJ5SCxXUj8ygf8/a58mfO3AcTXJ7q96vU
         QzoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=T+Oh1/B6hbL2ZKYAG1mQE+fKQr5P0O22f49MMo1Rn50=;
        b=VoCTQFl0VpVGJSUQ72yeT/9EoGy54TT1PprvbF0By9sfRj4iMadoOVaB/2aKAX1d2V
         e7kOJ9NVkWfmmXabb/u26zcLLxY5jOotJIx2syQzMpcPA7kFR4/pFVDXJ48rB1b6+pwA
         Lg4fDlzMbFzfyetoSftAO+fCDlXDLuOjP/dtKUhD28i8lBllBJ4fl/cPBExJDLxIhJNY
         iXNUAvAoc/0VD+rfKPDmxYwuesOvKGBBqWh38jpFMjk3CejrICszjaZaDWS20d+Y/PhU
         H5d3af05SDhk7f3ipFYrHTFa7y7o0qC19bG4YBN4V2F52x2NO3QHKe461swk1XqJjWM3
         moUQ==
X-Gm-Message-State: AG10YOQi0npyScKJXj6a2x8LGoaMkTcvR5vOICCAHlTAbwQyT3eoL81HTOqHxOs0j0rn6hIDHGeTj3qVg1DDdA==
X-Received: by 10.25.43.212 with SMTP id r203mr4604572lfr.162.1455451485925;
 Sun, 14 Feb 2016 04:04:45 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Sun, 14 Feb 2016 04:04:16 -0800 (PST)
In-Reply-To: <1454701462-3817-21-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286148>

On Sat, Feb 6, 2016 at 2:44 AM, David Turner <dturner@twopensource.com> wrote:
> +static char *get_refdb_path(const char *base)
> +{
> +       static struct strbuf path_buf = STRBUF_INIT;
> +       strbuf_reset(&path_buf);
> +       strbuf_addf(&path_buf, "%s/refdb", base);
> +       return path_buf.buf;
> +}
...
> +static int lmdb_init_db(struct strbuf *err, int shared)
> +{
> +       /*
> +        * To create a db, all we need to do is make a directory for
> +        * it to live in; lmdb will do the rest.
> +        */
> +
> +       if (!db_path)
> +               db_path = xstrdup(real_path(get_refdb_path(get_git_common_dir())));

This works for multiple worktrees. But scripts may have harder time
getting the path. The recommended way is "git rev-parse --git-path
refdb" but because "refdb" is not registered in path.c:common_list[],
that command becomes git_path("refdb") instead of
get_refdb(get_git_... like here. And I will need to know that
.git/refdb is _not_ per-worktree when I migrate/convert main worktree
(it's very likely I have to go that route to solve .git/config issue
in multi worktree).

The solution is register refdb to common_list[] and you can do
git_path("refdb") here. But then what happens when another backend is
added? Will the new backend use the same path "refdb", or say
"refdb.sqlite"? If all backends share the name "refdb", why can't we
just reuse "refs" instead because the default filesystem-based backend
is technically just another backend?
-- 
Duy
