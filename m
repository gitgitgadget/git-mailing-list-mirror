From: Michal Novotny <minovotn@redhat.com>
Subject: Re: [PATCH] daemon: --access-hook option
Date: Tue, 21 Aug 2012 12:57:35 +0200
Message-ID: <5033699F.5030207@redhat.com>
References: <feafacf49186d7cf0eed0002a82289b318f56ff8.1344938189.git.minovotn@redhat.com> <7v1uj98nbj.fsf@alter.siamese.dyndns.org> <CAJo=hJtYz3OX1C6HS7ivhJKBOSg=Ex3rKEdTYSbcDfFT1Jh4hw@mail.gmail.com> <7vsjbp768y.fsf@alter.siamese.dyndns.org> <CAJo=hJu7W6JnNLYvahaQ43ZNqDtrurTOLCnLfZacVJKeL6VMFg@mail.gmail.com> <7vpq6t9v5s.fsf@alter.siamese.dyndns.org> <7vobmc7n80.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 21 12:58:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3m9m-0001X9-Og
	for gcvg-git-2@plane.gmane.org; Tue, 21 Aug 2012 12:57:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756727Ab2HUK5n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Aug 2012 06:57:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49504 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756614Ab2HUK5k (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2012 06:57:40 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q7LAvcgG000562
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Tue, 21 Aug 2012 06:57:38 -0400
Received: from miglaptop.brq.redhat.com (dhcp-1-191.brq.redhat.com [10.34.1.191])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id q7LAvaWZ005238;
	Tue, 21 Aug 2012 06:57:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:14.0) Gecko/20120717 Thunderbird/14.0
In-Reply-To: <7vobmc7n80.fsf_-_@alter.siamese.dyndns.org>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203963>

Right, this approach of having ACL using the --access-hook option looks
much better. At least you got inspired this could be useful for somebody ;-)

Michal

On 08/15/2012 07:12 AM, Junio C Hamano wrote:
> The --access-hook option to "git daemon" specifies an external
> command to be run every time a client connects, with
>
>  - service name (e.g. "upload-pack", etc.),
>  - path to the repository,
>  - hostname (%H),
>  - canonical hostname (%CH),
>  - ip address (%IP),
>  - tcp port (%P)
>
> as its command line arguments.  The external command can decide to
> decline the service by exiting with a non-zero status (or to allow it
> by exiting with a zero status).  It can also look at the $REMOTE_ADDR
> and $REMOTE_PORT environment variables to learn about the requestor
> when making this decision.
>
> The external command can optionally write a single line to its
> standard output to be sent to the requestor as an error message when
> it declines the service.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>
>  * This time, minimally tested, with a documentation update.
>
>  Documentation/git-daemon.txt | 16 +++++++++
>  daemon.c                     | 77 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 93 insertions(+)
>
> diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
> index 31b28fc..c3ba4d7 100644
> --- a/Documentation/git-daemon.txt
> +++ b/Documentation/git-daemon.txt
> @@ -16,6 +16,7 @@ SYNOPSIS
>  	     [--reuseaddr] [--detach] [--pid-file=<file>]
>  	     [--enable=<service>] [--disable=<service>]
>  	     [--allow-override=<service>] [--forbid-override=<service>]
> +	     [--access-hook=<path>]
>  	     [--inetd | [--listen=<host_or_ipaddr>] [--port=<n>] [--user=<user> [--group=<group>]]
>  	     [<directory>...]
>  
> @@ -171,6 +172,21 @@ the facility of inet daemon to achieve the same before spawning
>  	errors are not enabled, all errors report "access denied" to the
>  	client. The default is --no-informative-errors.
>  
> +--access-hook=<path>::
> +	Every time a client connects, first run an external command
> +	specified by the <path> with service name (e.g. "upload-pack"),
> +	path to the repository, hostname (%H), canonical hostname
> +	(%CH), ip address (%IP), and tcp port (%P) as its command line
> +	arguments. The external command can decide to decline the
> +	service by exiting with a non-zero status (or to allow it by
> +	exiting with a zero status).  It can also look at the $REMOTE_ADDR
> +	and $REMOTE_PORT environment variables to learn about the
> +	requestor when making this decision.
> ++
> +The external command can optionally write a single line to its
> +standard output to be sent to the requestor as an error message when
> +it declines the service.
> +
>  <directory>::
>  	A directory to add to the whitelist of allowed directories. Unless
>  	--strict-paths is specified this will also include subdirectories
> diff --git a/daemon.c b/daemon.c
> index ab21e66..4602b46 100644
> --- a/daemon.c
> +++ b/daemon.c
> @@ -30,6 +30,7 @@ static const char daemon_usage[] =
>  "           [--interpolated-path=<path>]\n"
>  "           [--reuseaddr] [--pid-file=<file>]\n"
>  "           [--(enable|disable|allow-override|forbid-override)=<service>]\n"
> +"           [--access-hook=<path>]\n"
>  "           [--inetd | [--listen=<host_or_ipaddr>] [--port=<n>]\n"
>  "                      [--detach] [--user=<user> [--group=<group>]]\n"
>  "           [<directory>...]";
> @@ -256,6 +257,71 @@ static int daemon_error(const char *dir, const char *msg)
>  	return -1;
>  }
>  
> +static char *access_hook;
> +
> +static int run_access_hook(struct daemon_service *service, const char *dir, const char *path)
> +{
> +	struct child_process child;
> +	struct strbuf buf = STRBUF_INIT;
> +	const char *argv[8];
> +	const char **arg = argv;
> +	char *eol;
> +	int seen_errors = 0;
> +
> +#define STRARG(x) ((x) ? (x) : "")
> +	*arg++ = access_hook;
> +	*arg++ = service->name;
> +	*arg++ = path;
> +	*arg++ = STRARG(hostname);
> +	*arg++ = STRARG(canon_hostname);
> +	*arg++ = STRARG(ip_address);
> +	*arg++ = STRARG(tcp_port);
> +	*arg = NULL;
> +#undef STRARG
> +
> +	memset(&child, 0, sizeof(child));
> +	child.use_shell = 1;
> +	child.argv = argv;
> +	child.no_stdin = 1;
> +	child.no_stderr = 1;
> +	child.out = -1;
> +	if (start_command(&child)) {
> +		logerror("daemon access hook '%s' failed to start",
> +			 access_hook);
> +		goto error_return;
> +	}
> +	if (strbuf_read(&buf, child.out, 0) < 0) {
> +		logerror("failed to read from pipe to daemon access hook '%s'",
> +			 access_hook);
> +		strbuf_reset(&buf);
> +		seen_errors = 1;
> +	}
> +	if (close(child.out) < 0) {
> +		logerror("failed to close pipe to daemon access hook '%s'",
> +			 access_hook);
> +		seen_errors = 1;
> +	}
> +	if (finish_command(&child))
> +		seen_errors = 1;
> +
> +	if (!seen_errors) {
> +		strbuf_release(&buf);
> +		return 0;
> +	}
> +
> +error_return:
> +	strbuf_ltrim(&buf);
> +	if (!buf.len)
> +		strbuf_addstr(&buf, "service rejected");
> +	eol = strchr(buf.buf, '\n');
> +	if (eol)
> +		*eol = '\0';
> +	errno = EACCES;
> +	daemon_error(dir, buf.buf);
> +	strbuf_release(&buf);
> +	return -1;
> +}
> +
>  static int run_service(char *dir, struct daemon_service *service)
>  {
>  	const char *path;
> @@ -304,6 +370,13 @@ static int run_service(char *dir, struct daemon_service *service)
>  	}
>  
>  	/*
> +	 * Optionally, a hook can choose to deny access to the
> +	 * repository depending on the phase of the moon.
> +	 */
> +	if (access_hook && run_access_hook(service, dir, path))
> +		return -1;
> +
> +	/*
>  	 * We'll ignore SIGTERM from now on, we have a
>  	 * good client.
>  	 */
> @@ -1142,6 +1215,10 @@ int main(int argc, char **argv)
>  			export_all_trees = 1;
>  			continue;
>  		}
> +		if (!prefixcmp(arg, "--access-hook=")) {
> +			access_hook = arg + 14;
> +			continue;
> +		}
>  		if (!prefixcmp(arg, "--timeout=")) {
>  			timeout = atoi(arg+10);
>  			continue;

-- 
Michal Novotny <minovotn@redhat.com>, RHCE, Red Hat
Virtualization | libvirt-php bindings | php-virt-control.org
