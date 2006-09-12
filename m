From: Franck Bui-Huu <vagabon.xyz@gmail.com>
Subject: Re: [PATCH 3/3] Add sideband status report to git-archive protocol
Date: Tue, 12 Sep 2006 10:17:01 +0200
Message-ID: <45066CFD.5040202@innova-card.com>
References: <7vpse4tcyc.fsf@assigned-by-dhcp.cox.net>	<7vk64ctctv.fsf@assigned-by-dhcp.cox.net>	<7v1wqkt2v4.fsf_-_@assigned-by-dhcp.cox.net>	<45053BA2.6050502@innova-card.com> <7vzmd5eedk.fsf@assigned-by-dhcp.cox.net>
Reply-To: Franck <vagabon.xyz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Franck Bui-Huu <vagabon.xyz@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 12 10:17:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GN3SK-00008G-La
	for gcvg-git@gmane.org; Tue, 12 Sep 2006 10:17:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964975AbWILIRG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Sep 2006 04:17:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751289AbWILIQs
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Sep 2006 04:16:48 -0400
Received: from nz-out-0102.google.com ([64.233.162.205]:32035 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751282AbWILIQq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Sep 2006 04:16:46 -0400
Received: by nz-out-0102.google.com with SMTP id n1so681264nzf
        for <git@vger.kernel.org>; Tue, 12 Sep 2006 01:16:45 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=kAo63VYdMWKalEvrE3zVFXil5UicJRP6ppAx7N7Qu30vLzCSxFPwCJUE611atHzJXT4Ydc4rFgCXKoY5VqfHYNxjlrE32OTIHEgm6VU2/iO2xsQNEH0e30Kw2TCX5SglSEemi3z8Hrq0I+2khaPo2jkUlzfd3H0QsWynhFPH41I=
Received: by 10.65.114.11 with SMTP id r11mr3215201qbm;
        Tue, 12 Sep 2006 01:16:45 -0700 (PDT)
Received: from ?192.168.0.24? ( [81.252.61.1])
        by mx.gmail.com with ESMTP id q14sm4976312qbq.2006.09.12.01.16.43;
        Tue, 12 Sep 2006 01:16:44 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vzmd5eedk.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26883>

Junio C Hamano wrote:
> Franck Bui-Huu <vagabon.xyz@gmail.com> writes:
> 
>> I get a lot of "Hmph, HUP?" messages when testing "git-archive
>> --remote" command. One guess: this can be due to the fact that when
>> the writer process exits, it first closes its fd but do not send a
>> SIGCHLD signal right after to its parent.
> 
> It does not reproduce for me, but the code I have is obviously
> bogus in a few places.
> 
>  - When POLLHUP is set, it goes ahead and reads the file
>    descriptor.  Worse yet, it does not check the return value of
>    read() for errors when it does.
> 

The thing is that read() doesn't actually return an error in that
case instead it returns 0 meaning it saw EOF when reading on the
pipe. But I agree we should check for errors. FYI, here's an output
of strace on git-daemon. This trace is realized with the buggy code.

3070 read(5, "[core]\n\trepositoryformatversion "..., 4096) = 53
23070 read(5, "", 4096)                 = 0
23070 close(5)                          = 0
23070 munmap(0xb7f92000, 4096)          = 0
23070 write(1, "pax_global_header\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 10240) = 10240
23069 <... poll resumed> [{fd=5, events=POLLIN, revents=POLLIN}, {fd=7, events=POLLIN}], 2, -1) = 1
23069 read(5, "pax_global_header\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 16384) = 10240
23069 write(1, "2805\1", 5)             = 5
23069 write(1, "pax_global_header\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 10240) = 10240
23069 poll( <unfinished ...>
23070 write(1, "type f -iname \"$c-*\" | sed -e 1q"..., 10240) = 10240
23069 <... poll resumed> [{fd=5, events=POLLIN, revents=POLLIN}, {fd=7, events=POLLIN}], 2, -1) = 1
23069 read(5, "type f -iname \"$c-*\" | sed -e 1q"..., 16384) = 10240
23069 write(1, "2805\1", 5)             = 5
23069 write(1, "type f -iname \"$c-*\" | sed -e 1q"..., 10240) = 10240
23069 poll( <unfinished ...>
23070 exit_group(0)                     = ?
23069 <... poll resumed> [{fd=5, events=POLLIN, revents=POLLHUP}, {fd=7, events=POLLIN}], 2, -1) = 1
23069 read(5, "", 16384)                = 0
23069 waitpid(23070, 0xbfef3188, WNOHANG) = 0
23069 write(2, "Hmph, HUP?\n", 11)      = 11
23069 poll([{fd=5, events=POLLIN, revents=POLLHUP}, {fd=7, events=POLLIN}], 2, -1) = 1
23069 read(5, "", 16384)                = 0
23069 waitpid(23070, 0xbfef3188, WNOHANG) = 0
23069 write(2, "Hmph, HUP?\n", 11)      = 11

[...]

23077 poll([{fd=5, events=POLLIN, revents=POLLHUP}, {fd=7, events=POLLIN}], 2, -1) = 1
23077 read(5, "", 16384)                = 0
23077 waitpid(23078, 0xbf9bb448, WNOHANG) = 0
23077 --- SIGCHLD (Child exited) @ 0 (0) ---
23077 write(2, "Hmph, HUP?\n", 11)      = 11
23077 poll([{fd=5, events=POLLIN, revents=POLLHUP}, {fd=7, events=POLLIN, revents=POLLHUP}], 2, -1) = 2
23077 read(5, "", 16384)                = 0
23077 read(7, "", 16384)                = 0
23077 waitpid(23078, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], WNOHANG) = 23078
23077 write(1, "0000", 4)               = 4
23077 exit_group(0)                     = ?
23065 <... poll resumed> [{fd=3, events=POLLIN}, {fd=4, events=POLLIN}], 2, -1) = -1 EINTR (Interrupted system call)
23065 --- SIGCHLD (Child exited) @ 0 (0) ---
23065 waitpid(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], WNOHANG) = 23077
23065 time(NULL)                        = 1158047440

[...]

>  - When we processed one POLLIN, we should just go back and see
>    if any more data is available.  We can check if the child is
>    still there when poll gave control back at us but without any
>    actual input as you said.
> 
> I was uncomfortable letting waitpid() there to wait forever.
> When does poll() return?  (1) we have data ready in which case
> we process; (2) the child somehow closed the pipe but without
> dying, which is an error in the child.  In the latter case even
> not hanging in waitpid() and retrying the poll would not give
> any useful input so that would not help either.
> 

your case (2) is not totaly right. If you look a the trace above,
for the normal case, you can see that the child close the pipe then 
_after_ a while die. So there's a time when the child is not died
but the pipe is closed.

I think it's safe to assume that if the child closes the pipe, either
because it has finished to write or something wrong going on, then
it's going to die pretty soon. 

> So I think your patch is a correct fix, except that I think we
> should let the remote side know why we stopped talking to them
> instead of calling die() there.
> 
> We should also check when read() returns an error, so how about
> this on top of your patch?
> 
> diff --git a/builtin-upload-archive.c b/builtin-upload-archive.c
> index 2ebe9a0..a53cfee 100644
> --- a/builtin-upload-archive.c
> +++ b/builtin-upload-archive.c
> @@ -16,6 +16,9 @@ static const char upload_archive_usage[]
>  static const char deadchild[] =
>  "git-upload-archive: archiver died with error";
>  
> +static const char lostchild[] =
> +"git-upload-archive: archiver process was lost";
> +
>  
>  static int run_upload_archive(int argc, const char **argv, const char *prefix)
>  {
> @@ -73,6 +76,31 @@ static int run_upload_archive(int argc, 
>  	return ar.write_archive(&ar.args);
>  }
>  
> +static void error_clnt(const char *fmt, ...)
> +{
> +	char buf[1024];
> +	va_list params;
> +	int len;
> +
> +	va_start(params, fmt);
> +	len = vsprintf(buf, fmt, params);
> +	va_end(params);
> +	send_sideband(1, 3, buf, len, LARGE_PACKET_MAX);
> +	die("sent error to the client: %s", buf);
> +}
> +
> +static void process_input(int child_fd, int band)
> +{
> +	char buf[16384];
> +	ssize_t sz = read(child_fd, buf, sizeof(buf));
> +	if (sz < 0) {
> +		if (errno != EINTR)
> +			error_clnt("read error: %s\n", strerror(errno));
> +	}
> +	else if (sz)
> +		send_sideband(1, band, buf, sz, LARGE_PACKET_MAX);
> +}
> +


I think calling send_sideband() with sz = 0 should be fine, otherwise
this function is buggy, no ? So you can simply write process_input() like

static void process_input(int child_fd, int band)
{
	char buf[16384];
	ssize_t sz = read(child_fd, buf, sizeof(buf));
	if (sz < 0) {
		if (errno != EINTR)
			error_clnt("read error: %s\n", strerror(errno));
		return;
	}
	send_sideband(1, band, buf, sz, LARGE_PACKET_MAX);
}

		Franck
