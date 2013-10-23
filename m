From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: Re* [PATCH] remote-hg: unquote C-style paths when exporting
Date: Wed, 23 Oct 2013 17:53:15 +0200
Message-ID: <CALWbr2z-+S_rNFEKNH2fYJQmn1z9SyO2Z4sNDoz=Kh8P8Y_ccQ@mail.gmail.com>
References: <1382115821-12586-1-git-send-email-apelisse@gmail.com>
	<xmqq4n89t8yw.fsf@gitster.dls.corp.google.com>
	<CALWbr2zsOYNN45d+qHDQ88eLj82iV4QxJ_9ro+RGk7upBJVATA@mail.gmail.com>
	<CAMP44s37-R0u4oLnuRfdghx-Tk3X9eer0MVTcAGmPZ3Bu32dug@mail.gmail.com>
	<CALWbr2zzT47e_B0moy0a5gpWfhberp9B3TEwkGFBBm19iGfQBw@mail.gmail.com>
	<xmqqa9i0rnzo.fsf_-_@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 23 17:53:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZ0kL-0002s9-OB
	for gcvg-git-2@plane.gmane.org; Wed, 23 Oct 2013 17:53:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752013Ab3JWPxS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Oct 2013 11:53:18 -0400
Received: from mail-la0-f42.google.com ([209.85.215.42]:41166 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751509Ab3JWPxR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Oct 2013 11:53:17 -0400
Received: by mail-la0-f42.google.com with SMTP id ea20so851136lab.29
        for <git@vger.kernel.org>; Wed, 23 Oct 2013 08:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=OK4o+/WYjD7F2UkOmU6eZnJBmZS2e9bOsipxMl/dncY=;
        b=M+bB/jsWFgZeQVx66mDvx2lTxuT8rlYSo7Kw+xPyfXWbqggaPWA5vlmHyJPs3dJhbB
         elBd2r0wSx3rFg3LTJ4VkKuHK1hTXLmrD0mQ07ZMjCl2MtDv9uiTpEmSeDle5i9to6HJ
         lu8VJHFklhCsFQl4tC9/pgcJY3fBMgb0votgy7/hryJImLCLb3sOxZvPA5XIwgL7fcLS
         n2uA4OaRjjF0PFV2uT6ND/WMeG2cFhhLodRjXa/ZlzD14ve07IyNJlneprT6ervWmTpb
         K+n8wdHI+Cv2L/6kdW3VnxMNucxHOFTR+6cFdRQ3toKGPp1NJVrWzBIh2jRRQd/Q2Fvz
         tO5A==
X-Received: by 10.112.9.195 with SMTP id c3mr2565107lbb.33.1382543595871; Wed,
 23 Oct 2013 08:53:15 -0700 (PDT)
Received: by 10.112.50.240 with HTTP; Wed, 23 Oct 2013 08:53:15 -0700 (PDT)
In-Reply-To: <xmqqa9i0rnzo.fsf_-_@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236520>

On Wed, Oct 23, 2013 at 5:44 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Antoine Pelisse <apelisse@gmail.com> writes:
>
>>> def c_style_unescape(string):
>>>     if string[0] == string[-1] == '"':
>>>         return string.decode('string-escape')[1:-1]
>>>     return string
>>>
>>> It's in git-remote-bzr.py.
>>
>> Yeah, that's certainly better,
>>
>> Thanks,
>
> OK, so an amended one will look like this?

The commit message needs to be updated as well.

> -- >8 --
> From: Antoine Pelisse <apelisse@gmail.com>
> Subject: remote-hg: unquote C-style paths when exporting
>
> git-fast-import documentation says that paths can be C-style quoted.
> Unfortunately, the current remote-hg helper doesn't unquote quoted
> path and pass them as-is to Mercurial when the commit is created.
>
> This result in the following situation:

s/result/&s/

> - clone a mercurial repository with git
> - Add a file with space: `mkdir dir/foo\ bar`

- Add a file with space in a directory: `>dir/foo\ bar`

> - Commit that new file, and push the change to mercurial
> - The mercurial repository as now a new directory named '"dir', which
> contains a file named 'foo bar"'

I'm so ashamed I'd rather not report this one: s/as/has/

> Use python ast.literal_eval to unquote the string if it starts with ".

Use python str.decode('string-escape') to unquote the string if it
starts and ends with ".

> It has been tested with quotes, spaces, and utf-8 encoded file-names.
>
> Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  contrib/remote-helpers/git-remote-hg | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
> index 0194c67..85abbed 100755
> --- a/contrib/remote-helpers/git-remote-hg
> +++ b/contrib/remote-helpers/git-remote-hg
> @@ -678,6 +678,11 @@ def get_merge_files(repo, p1, p2, files):
>              f = { 'ctx' : repo[p1][e] }
>              files[e] = f
>
> +def c_style_unescape(string):
> +    if string[0] == string[-1] == '"':
> +        return string.decode('string-escape')[1:-1]
> +    return string
> +
>  def parse_commit(parser):
>      global marks, blob_marks, parsed_refs
>      global mode
> @@ -720,6 +725,7 @@ def parse_commit(parser):
>              f = { 'deleted' : True }
>          else:
>              die('Unknown file command: %s' % line)
> +        path = c_style_unescape(path).decode('utf-8')
>          files[path] = f
>
>      # only export the commits if we are on an internal proxy repo

That is consistent with git-remote-bzr,

Thanks
