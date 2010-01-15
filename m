From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH v2 13/14] daemon: use select() instead of poll()
Date: Sat, 16 Jan 2010 00:08:28 +0100
Message-ID: <40aa078e1001151508j208fa50boc5565a3be6bef893@mail.gmail.com>
References: <1263591033-4992-1-git-send-email-kusmabite@gmail.com>
	 <1263591033-4992-14-git-send-email-kusmabite@gmail.com>
	 <201001152349.06418.j6t@kdbg.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: msysgit@googlegroups.com, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sat Jan 16 00:08:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVvHN-0002cD-E9
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jan 2010 00:08:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758590Ab0AOXIa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Jan 2010 18:08:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758560Ab0AOXIa
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 18:08:30 -0500
Received: from mail-ew0-f209.google.com ([209.85.219.209]:39680 "EHLO
	mail-ew0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758360Ab0AOXI3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Jan 2010 18:08:29 -0500
Received: by ewy1 with SMTP id 1so673580ewy.28
        for <git@vger.kernel.org>; Fri, 15 Jan 2010 15:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=e5+ED/XOxMa60DtmOmz8cn3AS5WFAIQTU3huh+PpOAM=;
        b=i+IP8Uo6rrNGXdpVCYm2B3k3+Vz39EKrHISzuaOMw+beiH9hqlaMzo5L8wTwN8J/f7
         Jxy4fFPimow+vh7nIG4WhwglwHHz7Sapv2K0YVKOyL7KCMWRDr4rRJPdR7lH9HhJDOXj
         ul/1y11DcM6/wvO/nJsF9Xb/jxLlO4f4ODqvw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=i1SU1j0P8VG2aRNbMRvFuvKTmEtSKvz+OvcWXW2RYDoJ1vSUetP+e1asPSCoXJIYgC
         PuYpd7rA1/TzW1mqTB/sWbZ9s5lF9JIu7zzjyNgadkrd6JMQ9pBuIYaRBbzAqGvtUjJD
         kHtNLCuOeMtlYZQCsucq0pOG0YcfZf4FgKWfM=
Received: by 10.216.86.11 with SMTP id v11mr1045160wee.220.1263596908186; Fri, 
	15 Jan 2010 15:08:28 -0800 (PST)
In-Reply-To: <201001152349.06418.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137156>

On Fri, Jan 15, 2010 at 11:49 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> On Freitag, 15. Januar 2010, Erik Faye-Lund wrote:
>> +#undef FD_SET
>> +#define FD_SET(fd, set) do { \
>> + =A0 =A0 ((fd_set*)(set))->fd_array[((fd_set *)(set))->fd_count++] =
=3D
>> _get_osfhandle(fd); \ + =A0 =A0 =A0 } while(0)
>> +#undef FD_ISSET
>> +#define FD_ISSET(fd, set) __WSAFDIsSet(_get_osfhandle(fd), (fd_set
>> *)(set)) +
>
> I'm worried about the internals that you have to use here. Isn't it p=
ossible
> save the original macro text and use it in the new definition, like (=
this is
> for exposition only):
>
> #define ORIG_FD_SET(fd, set) FD_SET(fd, set)
> #undef FD_SET
> #define FD_SET(fd, set) ORIG_FD_SET(_get_osfhandle(fd), set)
>

Redefining it is indeed fishy - I guess I should also have noted that
I even stripped the code down slightly (compared to the original).

I'm no preprocessor wizard, but I'll give it a stab.

> Another approach would be to extend the poll emulation such that it u=
ses
> select if all FDs to wait for are sockets, and I think this would be =
the case
> in this application.
>

The problem with that is differentiating between pipes and sockets.
GetFileType() returns FILE_TYPE_PIPE for sockets (ugh). I did find
some code in gnulib that used WSAEnumNetworkEvents() to differentiate
between them, but I find this quite hacky.

--=20
Erik "kusma" Faye-Lund
