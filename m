From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [RFC/PATCH] Add an implementation of uname(1) for Windows
Date: Thu, 19 Nov 2009 19:00:19 +0000
Message-ID: <4B0595C3.6010206@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 19 20:02:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBCGq-0001Rn-6K
	for gcvg-git-2@lo.gmane.org; Thu, 19 Nov 2009 20:02:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754731AbZKSTCE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Nov 2009 14:02:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbZKSTCD
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Nov 2009 14:02:03 -0500
Received: from anchor-post-1.mail.demon.net ([195.173.77.132]:45092 "EHLO
	anchor-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754727AbZKSTCB (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Nov 2009 14:02:01 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-1.mail.demon.net with esmtp (Exim 4.69)
	id 1NBCGa-0004kB-j6
	for git@vger.kernel.org; Thu, 19 Nov 2009 19:02:06 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133246>


Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

While changing the Makefile recently, to fix-up the msvc build on
cygwin, I thought it may be useful to have a uname(1) command on
Windows. Well, it isn't actually needed, but it got me thinking
about how I would implement it...

I started off with some assembler to access the cpuid instruction
on x86 machines... but I soon discarded that, since all the information
I needed was already available via an WIN32 API or from the registry.

So, this is not a serious patch and is not meant for application.
However, some Windows users may find it useful... ;-)

ATB,
Ramsay Jones

 compat/vcbuild/uname.c |  475 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 475 insertions(+), 0 deletions(-)
 create mode 100644 compat/vcbuild/uname.c

diff --git a/compat/vcbuild/uname.c b/compat/vcbuild/uname.c
new file mode 100644
index 0000000..7ca6cdd
--- /dev/null
+++ b/compat/vcbuild/uname.c
@@ -0,0 +1,475 @@
+
+/*
+ * uname(1) for Windows
+ *
+ * This program is licensed under the GPL v2.
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2,
+ * as published by the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ */
+
+/*
+ * MSVC:         cl uname.c advapi32.lib
+ *
+ * Open Watcom:  wcl386 uname.c
+ *
+ * Cygwin gcc:   gcc -mno-cygwin -o uname uname.c
+ *
+ */
+
+#ifndef _WIN32_WINNT
+#define _WIN32_WINNT 0x0500
+#endif
+
+#include <windows.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdarg.h>
+#include <string.h>
+
+#define VERSION_STR "0.1"
+
+static char *prog;
+
+static int all       = 0;
+static int kernel    = 0;
+static int host      = 0;
+static int release   = 0;
+static int version   = 0;
+static int machine   = 0;
+static int processor = 0;
+static int hardware  = 0;
+static int os        = 0;
+
+static void set_program_name(char *argv0, char *def)
+{
+	static char name[256];
+	char *slash;
+	int len;
+
+	if (!argv0 || !*argv0) {
+		prog = def;
+		return;
+	}
+
+	/* get last path component */
+	if ((slash = strrchr(argv0, '/')) == NULL)
+		prog = argv0;
+	else
+		prog = slash+1;
+
+	/* check for win32 separator */
+	if ((slash = strrchr(prog, '\\')) != NULL)
+		prog = slash+1;
+
+	/* strip '.exe' suffix, if any */
+	len = strlen(prog);
+	if (len > 4 && strcmp(&prog[len-4], ".exe") == 0) {
+		if (len < sizeof(name)) {
+			strcpy(name, prog);
+			name[len-4] = '\0';
+			prog = name;
+		}
+	}
+}
+
+static void die(const char *fmt, ...)
+{
+	va_list ap;
+
+	if (prog)
+		fprintf(stderr, "%s: ", prog);
+	va_start(ap, fmt);
+	vfprintf(stderr, fmt, ap);
+	va_end(ap);
+	fprintf(stderr, "\n");
+	exit(1);
+}
+
+static void usage(void)
+{
+	printf("usage: %s [OPTION]...\n\n", prog);
+	printf("  -a, --all                "
+		      "print all information, except -p and -i\n");
+	printf("  -s, --kernel-name        "
+		      "print the kernel name\n");
+	printf("  -n, --nodename           "
+		      "print the network node hostname\n");
+	printf("  -r, --kernel-release     "
+		      "print the kernel release\n");
+	printf("  -v, --kernel-version     "
+		      "print the kernel version\n");
+	printf("  -m, --machine            "
+		      "print the machine hardware name\n");
+	printf("  -p, --processor          "
+		      "print the processor type\n");
+	printf("  -i, --hardware-platform  "
+		      "print the hardware platform\n");
+	printf("  -o, --operating-system   "
+		      "print the operating system\n");
+	printf("      --help               "
+		      "print this help and exit\n");
+	printf("      --version            "
+		      "print version information and exit\n");
+	printf("\n");
+	exit(0);
+}
+
+static void print_version(void)
+{
+	printf("%s version %s\n", prog, VERSION_STR);
+	exit(0);
+}
+
+static void do_long_option(char *opt)
+{
+	static struct { char *name; int *option; } tab[] = {
+		{ "--all",               &all       },
+		{ "--kernel-name",       &kernel    },
+		{ "--nodename",          &host      },
+		{ "--kernel-release",    &release   },
+		{ "--kernel-version",    &version   },
+		{ "--machine",           &machine   },
+		{ "--processor",         &processor },
+		{ "--hardware-platform", &hardware  },
+		{ "--operating-system",  &os        },
+		{ NULL,                  NULL       }
+	};
+	int i;
+
+	if (!opt || !*opt)
+		die("internal error: !opt || !*opt");
+
+	for (i = 0; tab[i].name; i++) {
+		if (strcmp(opt, tab[i].name) == 0) {
+			*tab[i].option = 1;
+			return;
+		}
+	}
+
+	if (strcmp(opt, "--help") == 0)
+		usage();          /* does not return */
+
+	if (strcmp(opt, "--version") == 0)
+		print_version();  /* does not return */
+
+	die("unknown option: '%s', try --help", opt);
+}
+
+static void do_short_options(char *opts)
+{
+	char *a = &opts[1];
+
+	while (*a) {
+		switch (*a) {
+			case 'a': all = 1;       break;
+			case 's': kernel = 1;    break;
+			case 'n': host = 1;      break;
+			case 'r': release = 1;   break;
+			case 'v': version = 1;   break;
+			case 'm': machine = 1;   break;
+			case 'p': processor = 1; break;
+			case 'i': hardware = 1;  break;
+			case 'o': os = 1;        break;
+			default:
+				  die("unknown option: '%c', try --help", *a);
+				  break;
+		}
+		++a;
+	}
+}
+
+static void process_args(int argc, char *argv[])
+{
+	int argpos = 1;
+
+	if (argc == 1)    /* no options... */
+		kernel = 1;  /* same as -s */
+
+	/* check for [OPTIONS]... */
+	while (argpos < argc) {
+		if (argv[argpos][0] != '-')  /* no option */
+			break;
+		if (argv[argpos][1] == '-')  /* --long option */
+			do_long_option(argv[argpos]);
+		else                         /* -short option(s) */
+			do_short_options(argv[argpos]);
+		argpos++;
+	}
+
+	/* no other args allowed */
+	if (argpos != argc)
+		die("unexpected argument: '%s', try --help", argv[argpos]);
+
+	if (all)
+		kernel = host = release = version = machine = os = 1;
+}
+
+static char *get_kernel(void)
+{
+	return "Windows";
+}
+
+static char *get_hostname(void)
+{
+	static char name[256];
+	unsigned long len = sizeof(name)-1;
+
+	if (GetComputerNameExA(ComputerNameDnsHostname, name, &len))
+		return name;
+	return "unknown";
+}
+
+static OSVERSIONINFO *get_version_info(void)
+{
+	static OSVERSIONINFO ver;
+	static int called;
+
+	if (!called) {
+		ver.dwOSVersionInfoSize = sizeof(OSVERSIONINFO);
+		GetVersionEx(&ver);
+		++called;
+	}
+	return &ver;
+}
+static char *get_release(void)
+{
+	static char str[256];
+	OSVERSIONINFO *v = get_version_info();
+	_snprintf(str, sizeof(str)-1, "%d.%d",
+			v->dwMajorVersion, v->dwMinorVersion);
+	return str;
+}
+
+static char *get_version(void)
+{
+	static char str[256];
+	OSVERSIONINFO *v = get_version_info();
+	_snprintf(str, sizeof(str)-1, "%d(%s)",
+			v->dwBuildNumber, v->szCSDVersion);
+	return str;
+}
+
+static SYSTEM_INFO *get_system_info(void)
+{
+	static SYSTEM_INFO sys;
+	static int called;
+
+	if (!called) {
+		GetSystemInfo(&sys);
+		++called;
+	}
+	return &sys;
+}
+
+static char *get_arch(int arch)
+{
+	static struct { int arch_enum; char *name; } tab[] = {
+		{ PROCESSOR_ARCHITECTURE_INTEL,   "INTEL"    },
+		{ PROCESSOR_ARCHITECTURE_MIPS,    "MIPS"     },
+		{ PROCESSOR_ARCHITECTURE_ALPHA,   "ALPHA"    },
+		{ PROCESSOR_ARCHITECTURE_PPC,     "PPC"      },
+		{ PROCESSOR_ARCHITECTURE_SHX,     "SHX"      },
+		{ PROCESSOR_ARCHITECTURE_ARM,     "ARM"      },
+		{ PROCESSOR_ARCHITECTURE_IA64,    "IA-64"    },
+		{ PROCESSOR_ARCHITECTURE_ALPHA64, "ALPHA-64" },
+		{ PROCESSOR_ARCHITECTURE_AMD64,   "AMD-64"   },
+		{ PROCESSOR_ARCHITECTURE_UNKNOWN, NULL       }
+	};
+	int i;
+
+	for (i = 0; tab[i].name; i++)
+		if (tab[i].arch_enum == arch)
+			return tab[i].name;
+	return NULL;
+}
+
+static char *get_x86_machine(int family)
+{
+	static char m[256];
+
+	switch (family) {
+		case 3: case 4: case 5: case 6:
+			_snprintf(m, sizeof(m)-1, "i%c86", family+'0');
+			break;
+		case 15: /* pentium 4 */
+			strcpy(m, "i686");
+			break;
+		default:
+			_snprintf(m, sizeof(m)-1, "x86 Family %d", family);
+			break;
+	}
+	return m;
+}
+
+static char *get_machine(void)
+{
+	SYSTEM_INFO *s = get_system_info();
+	char *arch = get_arch(s->wProcessorArchitecture);
+
+	if (arch) {
+		if (strcmp(arch, "INTEL") == 0)
+			return get_x86_machine(s->wProcessorLevel);
+		return arch;
+	}
+	return "unknown";
+}
+
+static char cpuinfo_key[] =
+	"HARDWARE\\DESCRIPTION\\System\\CentralProcessor\\0";
+
+static char *get_processor_name(void)
+{
+	static char cpu[256];
+	DWORD t, len = sizeof(cpu)-1;
+	LONG l;
+	HKEY key;
+
+	l = RegOpenKeyA(HKEY_LOCAL_MACHINE, cpuinfo_key, &key);
+	if (l != ERROR_SUCCESS)
+		return NULL;
+
+	l = RegQueryValueExA(key, "ProcessorNameString", NULL, &t, cpu, &len);
+	if (l != ERROR_SUCCESS)
+		l = RegQueryValueExA(key, "Identifier", NULL, &t, cpu, &len);
+
+	RegCloseKey(key);
+
+	if (l != ERROR_SUCCESS)
+		return NULL;
+
+	return cpu;
+}
+
+static char *map_sysinfo_to_cpu(void)
+{
+	static char cpu[256];
+	size_t n = sizeof(cpu)-1;
+	SYSTEM_INFO *s = get_system_info();
+	char *arch = get_arch(s->wProcessorArchitecture);
+
+	if (arch && (strcmp(arch, "INTEL") == 0)) {
+		int family = s->wProcessorLevel;
+		int model = (((s->wProcessorRevision) >> 8) & 0xff);
+		int stepping = ((s->wProcessorRevision) & 0xff);
+
+		_snprintf(cpu, n, "x86 Family %d Model %d Stepping %d",
+				family, model, stepping);
+		return cpu;
+	}
+	return NULL;
+}
+
+static char *get_processor(void)
+{
+	char *cpu = get_processor_name();
+
+	if (cpu || (cpu = map_sysinfo_to_cpu()))
+		return cpu;
+
+	return "unknown";
+}
+
+static char *get_hardware(void)
+{
+	return "unknown";
+}
+
+static char osinfo_key[] =
+	"SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion";
+
+static char *get_product_name(void)
+{
+	static char product[256];
+	DWORD type, len = sizeof(product)-1;
+	LONG l;
+	HKEY key;
+
+	l = RegOpenKeyA(HKEY_LOCAL_MACHINE, osinfo_key, &key);
+	if (l != ERROR_SUCCESS)
+		return NULL;
+
+	l = RegQueryValueExA(key, "ProductName", NULL, &type, product, &len);
+
+	RegCloseKey(key);
+
+	if (l != ERROR_SUCCESS)
+		return NULL;
+
+	return product;
+}
+
+/*
+ * The OS version does not provide a unique mapping to OS product name.
+ * So, use this function only as a last resort.
+ */
+static char *map_version_to_os(void)
+{
+	static struct { int version; char *os_name; } tab[] = {
+		{ 0x500, "Windows 2000"        },
+		{ 0x501, "Windows XP"          },
+		{ 0x502, "Windows Server 2003" }, /* also Server 2003 R2 */
+		{ 0x600, "Windows Vista"       }, /* also Server 2008    */
+		{ 0x601, "Windows 7"           }, /* also Server 2008 R2 */
+		{ 0,     NULL                  }
+	};
+	OSVERSIONINFO *v = get_version_info();
+	int i, version = (v->dwMajorVersion << 8) + v->dwMinorVersion;
+
+	for (i = 0; tab[i].version != 0; i++) {
+		if (version == tab[i].version)
+			return tab[i].os_name;
+	}
+
+	return NULL;
+}
+
+static char *get_os(void)
+{
+	char *os_name = get_product_name();
+
+	if (os_name || (os_name = map_version_to_os()))
+		return os_name;
+
+	return "Windows";
+}
+
+static void print_info(void)
+{
+	static struct { int *opt; char *(*get)(void); } info[] = {
+		{ &kernel,    get_kernel    },
+		{ &host,      get_hostname  },
+		{ &release,   get_release   },
+		{ &version,   get_version   },
+		{ &machine,   get_machine   },
+		{ &processor, get_processor },
+		{ &hardware,  get_hardware  },
+		{ &os,        get_os        },
+		{ NULL,       0             }
+	};
+	char *pad = "";
+	int i;
+
+	for (i = 0; info[i].opt; i++) {
+		if (*(info[i].opt)) {
+			printf("%s%s", pad, (info[i].get)());
+			pad = " ";
+		}
+	}
+	printf("\n");
+}
+
+int main(int argc, char *argv[])
+{
+	set_program_name(argv[0], "uname");
+	process_args(argc,argv);
+	print_info();
+	return 0;
+}
-- 
1.6.5
