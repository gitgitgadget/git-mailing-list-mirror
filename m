From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] inotify to minimize stat() calls
Date: Sun, 28 Apr 2013 06:56:59 +0700
Message-ID: <CACsJy8BuMsdAAxPoY_R0tOKJ9toTnDwAwOx_=vmbOOpFLWmS5A@mail.gmail.com>
References: <CALkWK0=EP0Lv1F_BArub7SpL9rgFhmPtpMOCgwFqfJmVE=oa=A@mail.gmail.com>
 <7vehgqzc2p.fsf@alter.siamese.dyndns.org> <7va9rezaoy.fsf@alter.siamese.dyndns.org>
 <7vsj56w5y9.fsf@alter.siamese.dyndns.org> <9AF8A28B-71FE-4BBC-AD55-1DD3FDE8FFC3@gmail.com>
 <CALkWK0mttn6E+D-22UBbvDCuNEy_jNOtBaKPS-a8mTbO2uAF3g@mail.gmail.com>
 <7vliaxwa9p.fsf@alter.siamese.dyndns.org> <CAKXa9=qQwJqxZLxhAS35QeF1+dwH+ukod0NfFggVCuUZHz-USg@mail.gmail.com>
 <51781455.9090600@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Robert Zeh <robert.allan.zeh@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 28 01:57:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWEzx-0003Ui-Pw
	for gcvg-git-2@plane.gmane.org; Sun, 28 Apr 2013 01:57:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754513Ab3D0X5a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Apr 2013 19:57:30 -0400
Received: from mail-oa0-f42.google.com ([209.85.219.42]:61792 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751870Ab3D0X53 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Apr 2013 19:57:29 -0400
Received: by mail-oa0-f42.google.com with SMTP id i10so5122715oag.29
        for <git@vger.kernel.org>; Sat, 27 Apr 2013 16:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=ahgkJO1/jHxpn+0HDld/wYuTebvQxpW6lG14P245LSw=;
        b=woOE2euOLC2MQ3Q3LJ2wuJceZzjHxTgDM3rsoxb9bepbHNkduC8QlwP6WbxIqyuVVM
         Amq9/Z9ER4lC6EPClv07T9VQuHtZuLzzAbs0ZFSfL+i5U0uEhusl4irqx1oaP/XMtxKu
         EXOPLQrWKeQAL2P7Z1SWcAamMREx3TNkVjdEKZEQZiWp3ZpGt+13l+VOSYyYma/U8xIn
         elJnZYK34/OV/iZOF4ZPZWeo7MdBq0JZdFzNj/vDjXfI/WuBmvnCWEX9Z77IVYWZBV4P
         62Pl9Ts5mYfybZI4ESJp52fKE2DfU2JMLYajtbvnf6vlcdKVpkXKxUQ/SR4GLndFDLHt
         Zj7Q==
X-Received: by 10.182.148.231 with SMTP id tv7mr20498824obb.38.1367107049160;
 Sat, 27 Apr 2013 16:57:29 -0700 (PDT)
Received: by 10.76.180.138 with HTTP; Sat, 27 Apr 2013 16:56:59 -0700 (PDT)
In-Reply-To: <51781455.9090600@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222716>

On Thu, Apr 25, 2013 at 12:20 AM, Robert Zeh <robert.allan.zeh@gmail.com> wrote:
> +int cached_lstat(const char *path, struct stat *buf)
> +{
> +       int stat_return_value = 0;
> +       struct stat_cache_entry *entry = 0;
> +
> +       read_stat_cache();
> +
> +       entry = get_stat_cache_entry(path);
> +
> +       stat_return_value = lstat(path, buf);
> +
> +       if (entry && (stat_return_value != entry->stat_return) &&
> +           (memcpy(&entry->st, buf, sizeof(*buf)))) {
> +               abort();
> +       }
> +
> +       return stat_return_value;
> +}

I must be missing something. If you always do lstat() in
cached_lstat(), what's the point of the cache? If you worry about
integrity (in the abort case), it'll be easier if you just record and
send paths from the daemon to git. Then you do lstat at one place
(git). This function may become more complex if still want to watch a
worktree way bigger that inotify limit. But I guess for now we could
just exit the daemon early in that case and fall back to normal lstat.
--
Duy
