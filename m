From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: Make the git codebase thread-safe
Date: Thu, 13 Feb 2014 23:51:48 +0100
Message-ID: <52FD4C84.7060209@gmail.com>
References: <CA+TurHgyUK5sfCKrK+3xY8AeOg0t66vEvFxX=JiA9wXww7eZXQ@mail.gmail.com> <CABPQNSZ_LLg5i+mpwUj7pzXVQMY1tcXz2gJ+PWG-mP1iyjxoaw@mail.gmail.com> <CAHOQ7J8QxfvtrS2KdgzUPvkDzJ1Od0CMvdWxrF_bNacVRYOa5Q@mail.gmail.com> <CABPQNSZtQd51gQY7oK8B-BbpNEhxR-onQtiXSfW9sv1t2YW_nw@mail.gmail.com> <CAHOQ7J_Jrj1NJ_tZaCioskQU_xGR2FQPt8=JrWpR6rfs=c847w@mail.gmail.com> <CABPQNSYVGc9m0_xfAWe=3b7CXyGZ-2FfTMRbTJ=UECeZUtdgmg@mail.gmail.com> <52FBC9E5.6010609@gmail.com> <loom.20140213T193220-631@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Zachary Turner <zturner@chromium.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 13 23:51:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WE58J-0005uO-J1
	for gcvg-git-2@plane.gmane.org; Thu, 13 Feb 2014 23:51:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751854AbaBMWvr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Feb 2014 17:51:47 -0500
Received: from mail-ea0-f177.google.com ([209.85.215.177]:41797 "EHLO
	mail-ea0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751199AbaBMWvr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Feb 2014 17:51:47 -0500
Received: by mail-ea0-f177.google.com with SMTP id m10so2779099eaj.22
        for <git@vger.kernel.org>; Thu, 13 Feb 2014 14:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=hEBUl7aASsjKERjE8l9aXgGOso3BpluODBbfLfZIzKA=;
        b=mBfjCp6OlWNaIgjiS078HGONRW+/GIS4ufomZeXWgGn0y13wpAk2yBHDSErYWHrWbf
         aOLt4rMOSekFdOCWGuZ++x00jJwBUutzXUypVmFkZXSjQU2cTmPLuoOiegLVsCEOtMaz
         XmYsB0jecAE+rs9PS4FoBJz37wsRYkP7EQ6S8MsIVlkWbm4fUmXJZoJhWRVaBjKEC5WK
         JrNXiB87/XlU7TpSztw+OJ2e8otpHUj2qZHmi5AQhzxLNAZmLliGxrD2jlJeX/j4BU4z
         3jlPEUSg9ZPHExpqUw4uM3pCG6TOA4awONcT5YObOEgzOHj6JO9rqYpVet/yTKqH9zrj
         w6zA==
X-Received: by 10.15.98.68 with SMTP id bi44mr4637106eeb.67.1392331905825;
        Thu, 13 Feb 2014 14:51:45 -0800 (PST)
Received: from [10.1.100.54] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id y47sm12261538eel.14.2014.02.13.14.51.44
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 13 Feb 2014 14:51:44 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <loom.20140213T193220-631@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242083>

Am 13.02.2014 19:38, schrieb Zachary Turner:

> The only reason ReOpenFile is necessary at 
> all is because some code somewhere is mixing read-styles against the same 
> fd.
> 

I don't understand...ReadFile with OVERLAPPED parameter doesn't modify the HANDLE's file position, so you should be able to mix read()/pread() however you like (as long as read() is only called from one thread).

I tried without ReOpenFile and it seems to work like a charm, or am I missing something?

----8<----
ssize_t mingw_pread(int fd, void *buf, size_t count, off64_t offset)
{
	DWORD bytes_read;
	OVERLAPPED overlapped;
	memset(&overlapped, 0, sizeof(overlapped));
	overlapped.Offset = (DWORD) offset;
	overlapped.OffsetHigh = (DWORD) (offset >> 32);

	if (!ReadFile((HANDLE) _get_osfhandle(fd), buf, count, &bytes_read,
	    &overlapped)) {
		errno = err_win_to_posix(GetLastError());
		return -1;
	}
	return (ssize_t) bytes_read;
}
