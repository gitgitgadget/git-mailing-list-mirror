From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3] skip_prefix: rewrite so that prefix is scanned once
Date: Tue, 4 Mar 2014 08:58:19 +0700
Message-ID: <20140304015819.GA10643@duynguyen-vnpc.dek-tpc.internal>
References: <1393816384-3300-1-git-send-email-siddharth98391@gmail.com>
 <xmqqvbvvp0gj.fsf@gitster.dls.corp.google.com>
 <xmqq61nuoqd5.fsf@gitster.dls.corp.google.com>
 <CACsJy8ASBeravdk67pbOJbrFUbwg21JwYcLtSbDDMJOu9-F=yA@mail.gmail.com>
 <877g8akenw.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Siddharth Goel <siddharth98391@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Tue Mar 04 02:58:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKecr-00027J-2F
	for gcvg-git-2@plane.gmane.org; Tue, 04 Mar 2014 02:58:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755255AbaCDB63 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 20:58:29 -0500
Received: from mail-pa0-f42.google.com ([209.85.220.42]:53798 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755147AbaCDB62 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 20:58:28 -0500
Received: by mail-pa0-f42.google.com with SMTP id fb1so3037521pad.29
        for <git@vger.kernel.org>; Mon, 03 Mar 2014 17:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=JfMWPdSBv0jkBmDuRYIpPz1/xtjS4qsBZai8j3UHVsA=;
        b=r87M2maq3TN7iX3YXtgYDHIoZRgwQorwy+i78FxsLIwvlZsdjL2ILErq8dLjEhkOjZ
         KMvlUoB0LHy50MrJASSvPb69r27Z4lpUf+wsHyVU8rCjitPJ5zr1xRc6Qc9sq0IYwL6D
         PZMFGd7x6TwbBOdF3AUyfOc/i62lgXeWxfwxLH3UAbNrNlve06q0yLVgqLsIEtIyxhWX
         HHXrSI+oNqTaVnsEOhyQ/jwGwGVkXD2y/Ccsgy68Q69vwhNvPxAPMXEDtUaUBzvpNbJ2
         kqAL5bjcMpDJxLNITgJ2ma1FfODz2c/KuLY+B9KZ7nemlDo8H4G9SgW/poEyW7ilp1Dd
         1RDA==
X-Received: by 10.68.196.168 with SMTP id in8mr7437550pbc.132.1393898307359;
        Mon, 03 Mar 2014 17:58:27 -0800 (PST)
Received: from pclouds@gmail.com ([14.161.32.83])
        by mx.google.com with ESMTPSA id eb5sm94485606pad.22.2014.03.03.17.58.23
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 03 Mar 2014 17:58:26 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 04 Mar 2014 08:58:19 +0700
Content-Disposition: inline
In-Reply-To: <877g8akenw.fsf@fencepost.gnu.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243321>

On Tue, Mar 04, 2014 at 01:09:39AM +0100, David Kastrup wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
> 
> > On Tue, Mar 4, 2014 at 5:43 AM, Junio C Hamano <gitster@pobox.com> wrote:
> >> diff --git a/git-compat-util.h b/git-compat-util.h
> >> index cbd86c3..68ffaef 100644
> >> --- a/git-compat-util.h
> >> +++ b/git-compat-util.h
> >> @@ -357,8 +357,14 @@ extern int suffixcmp(const char *str, const char *suffix);
> >>
> >>  static inline const char *skip_prefix(const char *str, const char *prefix)
> >>  {
> >> -       size_t len = strlen(prefix);
> >> -       return strncmp(str, prefix, len) ? NULL : str + len;
> >
> > Just a note. gcc does optimize strlen("abcdef") to 6, and with that
> > information at compile time built-in strncmp might do better.
> 
> Indeed, most (but not all) of the calls have a constant string as
> prefix.  However, strncmp in each iteration checks for both *str as well
> as *prefix to be different from '\0' independently (and it appears
> unlikely to me that the optimizer will figure out that it's unnecessary
> for either) _and_ compares them for equality so it's not likely to be
> faster than the open-coded loop.
> 
> One could, however, use memcmp instead of strncmp.  I'm just not sure
> whether memcmp is guaranteed not to peek beyond the first mismatching
> byte even if the count would allow for more.  It could lead to undefined
> behavior if the first mismatching byte would be the ending NUL byte of
> str.

It turns out gcc does not generate a call to strncmp either. It
inlines repz cmpsb instead. I recall we had a discussion long ago
about the inefficiency of repz and and open-coded loop is preferred,
maybe that was about hashcmp. Anyway this does not matter much as
skip_prefix() is unlikely to be in any critical path, so I think
readability has higher priority.

For the curious, this small C program

-- 8< --
#include <stdio.h>
#include <string.h>

static inline const char *skip(const char *str, const char *prefix)
{
        int len = strlen(prefix);
        return strncmp(str, prefix, len) ? NULL : str + len;
}
int main(int ac, char **av)
{
        const char *s = skip(av[1], "foo");
        printf("%s\n", s);
        return 0;
}
-- 8< --

produces this assembly with gcc -O2 (on x86, apparently)

-- 8< --
00000000 <main>:
   0:   55                      push   %ebp
   1:   b9 03 00 00 00          mov    $0x3,%ecx
   6:   89 e5                   mov    %esp,%ebp
   8:   57                      push   %edi
   9:   bf 00 00 00 00          mov    $0x0,%edi
   e:   56                      push   %esi
   f:   53                      push   %ebx
  10:   83 e4 f0                and    $0xfffffff0,%esp
  13:   83 ec 10                sub    $0x10,%esp
  16:   8b 45 0c                mov    0xc(%ebp),%eax
  19:   8b 40 04                mov    0x4(%eax),%eax
  1c:   89 c6                   mov    %eax,%esi
  1e:   f3 a6                   repz cmpsb %es:(%edi),%ds:(%esi)
  20:   0f 97 c3                seta   %bl
  23:   0f 92 c1                setb   %cl
  26:   83 c0 03                add    $0x3,%eax
  29:   31 d2                   xor    %edx,%edx
  2b:   38 cb                   cmp    %cl,%bl
  2d:   0f 44 d0                cmove  %eax,%edx
  30:   89 14 24                mov    %edx,(%esp)
  33:   e8 fc ff ff ff          call   34 <main+0x34>
  38:   8d 65 f4                lea    -0xc(%ebp),%esp
  3b:   31 c0                   xor    %eax,%eax
  3d:   5b                      pop    %ebx
  3e:   5e                      pop    %esi
  3f:   5f                      pop    %edi
  40:   5d                      pop    %ebp
  41:   c3                      ret
-- 8< --
--
Duy
